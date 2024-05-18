import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/model/base_response.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:dio/dio.dart';

class ResponseHandler with BaseMixin {
  static const String errorMessageTitle = "Error";

  static const String errorMessageDetails = "An error occurred";

  void alertErrorMessage(String? message) {
    snakeBar(message ?? ResponseHandler.errorMessageDetails);
  }

  void checkResponse(BaseResult result, bool showErrorMessage,
      BaseResponse? response, dynamic json, DioError? error) {
    switch (result) {
      case BaseResult.success:
        Logger.log('Success Response');
        break;
      case BaseResult.emptyResponse:
        Logger.log('Empty Response');
        final String message = ResponseHandler.getErrorsFromJson(json);
        if (showErrorMessage) {
          alertErrorMessage(message);
        }
        break;
      case BaseResult.failure:
        Logger.log('Failure');
        Logger.log('Message ${response?.message}');
        final String message = ResponseHandler.getErrorsFromJson(json);
        Logger.log(message);
        if (showErrorMessage) {
          alertErrorMessage(message);
        }
        break;
      case BaseResult.responseError:
        final String message = ResponseHandler.getErrorsFromJson(json);
        if (showErrorMessage) {
          alertErrorMessage(message);
        }
        Logger.log('Response Error');
        break;
    }
  }

  static String getErrorsFromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return ResponseHandler.errorMessageDetails;
    var errors = StringBuffer();

    if (json?.containsKey("message") == true) {
      errors.writeln(json["message"]);
    }

    // if (json?.containsKey("errors") == false &&
    //     (json?.containsKey("message") == true)) {
    //   errors.writeln(json["message"]);
    // }

    if (json?.containsKey("exception") == true) {
      errors.writeln(
          json["exception"].substring(json["exception"].lastIndexOf('\\') + 1));
    }
    if (Constants.isDebug) {
      if (json?.containsKey("file") == true) {
        errors
            .writeln(json["file"].substring(json["file"].lastIndexOf('/') + 1));
      }

      if (json?.containsKey("line") == true)  {
        errors.writeln("line:${json["line"]}");
      }
    }

    if (json?.containsKey("errors") == true) {
      json?["errors"].forEach((i, value) {
        errors.writeln(value[0]);
      });
    }

    return errors.toString().trim();
  }
}
