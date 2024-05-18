import 'package:mon/model/base_model.dart';
import 'package:mon/model/base_response.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/web_service/base_request.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/web_service/response_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

typedef SuccessCallback = void Function(BaseResponse response);
typedef FailureCallback = void Function(
    BaseResponse? response, dynamic json, DioError? error);

enum BaseResult { success, emptyResponse, responseError, failure }

class RequestBuilder {
  // static final RequestBuilder shared = RequestBuilder._internal();
  RequestBuilder();

  BaseRequest? _request;
  BaseResult result = BaseResult.emptyResponse;
  bool _showLoader = true;
  bool _showErrorMessage = true;
  ResponseHandler responseHandler = ResponseHandler();
  Map<String, dynamic> _parameters = {};
  Map<String, dynamic> _extra_parameters = {};

  // RequestBuilder._internal();

  SuccessCallback? _successResponse;
  FailureCallback? _failureResponse;

  RequestBuilder response(
      SuccessCallback? successResponse, FailureCallback? failureResponse) {
    _successResponse = successResponse;
    _failureResponse = failureResponse;
    return this;
  }

  RequestBuilder success(SuccessCallback? handler) {
    response(handler, (response, json, error) {
      responseHandler.checkResponse(
          result, _showErrorMessage, response, json, error);
    });
    return this;
  }

  // factory RequestBuilder() {
  //   return shared;
  // }

  Dio get _dio {
    final dio = Dio(BaseOptions(
      baseUrl: UserProfile.shared.baseURL,
      receiveTimeout: const Duration(seconds: Constants.receiveTimeout),
      connectTimeout: const Duration(seconds: Constants.connectTimeout),
      sendTimeout: const Duration(seconds: Constants.sendTimeout),
      headers: BaseModel.shared.headers,
    ));
    // dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(LogInterceptors());

    return dio;
  }

  RequestBuilder setRequest(BaseRequest request) {
    _request = request;
    return this;
  }

  RequestBuilder setOptions(
      {bool showErrorMessage = false, bool showLoader = false}) {
    _showErrorMessage = showErrorMessage;
    _showLoader = showLoader;
    return this;
  }

  RequestBuilder send() {
    build();
    return this;
  }

  Future<BaseResponse> sendAsync() async {
    return await build();
  }

  void _setParameters() {
    _parameters = _request?.params ?? {};
    _parameters = {..._parameters, ..._extra_parameters};
  }

  RequestBuilder setPagination({required int page, required int limit}) {
    _extra_parameters[Constants.pageKey] = page;
    _extra_parameters[Constants.pageSizeKey] = limit;
    return this;
  }

  Future<BaseResponse> build() async {
    if (_request == null) {
      throw Exception('setRequest should be called before build function.');
    }
    _setParameters();
    if (_showLoader) {
      EasyLoading.show();
    }
    try {
      final method = _request?.type ?? HttpMethods.get;
      final hasFile = (_request?.files.length ?? 0) > 0;
      final url =
          (_request?.baseUrl ?? Constants.apiUrl) +
              (_request?.url ?? Constants.apiUrl);
      Response? res;
      if (hasFile || (_request?.isSendRequestInMultipart ?? false)) {
        var formData = FormData.fromMap(_parameters);
        for (BaseRequestFile file in (_request?.files ?? [])) {
          if (file.data?.path != null) {
            formData.files.add(MapEntry(
                file.parameterName,
                MultipartFile.fromFileSync(file.data!.path,
                    filename: file.fileName)));
          }
        }
        res = await _dio.request(url,
            data: formData,
            options: Options(
                method: method.value ?? HttpMethods.get.value,
                receiveTimeout:
                    const Duration(seconds: Constants.receiveTimeout),
                sendTimeout: const Duration(seconds: Constants.sendTimeout),
                headers: {
                  ...BaseModel.shared.headers,
                  ...(_request?.additionalHeaders ?? {})
                }));
      } else {
        res = await _dio.request(url,
            data: method != HttpMethods.get ? _parameters : null,
            queryParameters:
                method == HttpMethods.get ? _parameters : null,
            options: Options(
                method: method.value ?? HttpMethods.get.value,
                receiveTimeout:
                    const Duration(seconds: Constants.receiveTimeout),
                sendTimeout: const Duration(seconds: Constants.sendTimeout),
                headers: {
                  ...BaseModel.shared.headers,
                  ...(_request?.additionalHeaders ?? {})
                }));
      }
      EasyLoading.dismiss(animation: true);
      final response = BaseResponse.fromJson(res.data);
      if (response.status == null &&
          response.code == null &&
          response.data == null) {
        result = BaseResult.emptyResponse;
      }
      final status = response.getResponseStatus(res);
      if (status == true) {
        result = BaseResult.success;
        if (_successResponse != null) _successResponse!(response);
        return response;
      } else {
        result = BaseResult.failure;
        if (_failureResponse != null) {
          _failureResponse!(response, res.data, null);
        }
        return response;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss(animation: true);
      Logger.log('Catch DioError Failure');
      BaseResponse? response;
      if (e.response?.data != null) {
        response = BaseResponse.fromJson(e.response?.data);
        result = BaseResult.failure;
      } else {
        result = BaseResult.responseError;
      }
      if (_failureResponse != null) {
        _failureResponse!(response, e.response?.data, e);
      }
      if (response != null) {
        return response!;
      } else {
        rethrow;
      }
    } catch (e) {
      EasyLoading.dismiss(animation: true);
      result = BaseResult.responseError;
      Logger.log('Catch Failure');
      Logger.log('Error: ${e.toString()}');
      rethrow;
    }
  }
}

class LogInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Constants.showRequestLog) {
      Logger.log('=======> Start Request <=======');
      Logger.log("Url: ${options.path}");
      Logger.log("Method: ${options.method}");
      Logger.log("parameters: ${Logger.beautify(options.queryParameters)}");
      Logger.log("Body: ${Logger.beautify(options.data)}");
      Logger.log("headers: ${Logger.beautify(options.headers)}");
      Logger.log('=======> Request <=======');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final RequestOptions options = response.requestOptions;
    if (Constants.showRequestLog) {
      Logger.log('=======> Request <=======');
      Logger.log("Url: ${options.path}");
      Logger.log("parameters: ${Logger.beautify(options.queryParameters)}");
      Logger.log("Body: ${Logger.beautify(options.data)}");
      Logger.log("headers: ${Logger.beautify(options.headers)}");
      Logger.log('=======> Request <=======');
      Logger.log('=======> Response <=======');
      Logger.json(response.data);
      Logger.log('=======> Response <=======');
      Logger.log('=======> End Request <=======');
    }
    return handler.next(response);
  }

  @override
  void onError(DioError e, ErrorInterceptorHandler handler) async {
    if (Constants.showRequestLog) {
      final RequestOptions options = e.requestOptions;
      Logger.log('=======> ERROR <=======');
      Logger.log("Url: ${options.path}");
      Logger.log("parameters: ${Logger.beautify(options.queryParameters)}");
      Logger.log("Body: ${Logger.beautify(options.data)}");
      Logger.log("headers: ${Logger.beautify(options.headers)}");
      Logger.log("message: ${e.message}");
      Logger.log("code: ${e.response?.statusCode}");
      Logger.log("type: ${e.type}");
      Logger.log('=======> Response <=======');
      Logger.json(e.response?.data);
      Logger.log('=======> Response <=======');
      Logger.log('=======> ERROR <=======');
      Logger.log('=======> End Request <=======');
    }

    // if (e.response?.statusCode == 401) {
    //   try {
    //     Response<dynamic> data = await _dio.get("your_refresh_url");
    //     token = data.data['newToken'];
    //     _customSharedPreferences.setToken(data.data['newToken']);
    //     options.headers["Authorization"] =  data.data['newToken'];
    //   } catch (err) {
    //     return err;
    //   }
    // }

    // switch (e.type) {
    //   case DioErrorType.connectionTimeout:
    //   case DioErrorType.sendTimeout:
    //   case DioErrorType.receiveTimeout:
    //     throw Exception('The connection has timed out, please try again.');
    //   case DioErrorType.badResponse:
    //     switch (e.response?.statusCode) {
    //       case 400:
    //         throw Exception('Invalid request');
    //       case 401:
    //         throw Exception('Access denied');
    //       case 404:
    //         throw Exception('The requested information could not be found');
    //       case 409:
    //         throw Exception('Conflict occurred');
    //       case 500:
    //         throw Exception('Unknown error occurred, please try again later.');
    //     }
    //     break;
    //   case DioErrorType.cancel:
    //     break;
    //   case DioErrorType.unknown:
    //   // throw Exception('No internet connection detected, please try again.');
    // }

    return handler.next(e);
  }
}
