//************************* Jsonify *************************/
// Created by Jsonify on 2023-05-04
// Copyright (c) Jsonify. All rights reserved.
// Visit our website https://jsonify.net


import 'package:flutter/foundation.dart';
import '../base_request.dart';
import '../constants.dart';


enum AuthRoutes {  login,   logout,   profile,   updateProfile,   updateFCM  }

class AuthRequest extends BaseRequest {
  
  String? email;
  String? password;
  String? first_name;
  String? last_name;
  String? mobile;
  String? company_name;
  String? user_type;
  String? account_type;
  String? avatar;
  String? role_id;
  
  final String _paramKey_email = "email";
  final String _paramKey_password = "password";
  final String _paramKey_first_name = "first_name";
  final String _paramKey_last_name = "last_name";
  final String _paramKey_mobile = "mobile";
  final String _paramKey_company_name = "company_name";
  final String _paramKey_user_type = "user_type";
  final String _paramKey_account_type = "account_type";
  final String _paramKey_avatar = "avatar";
  final String _paramKey_role_id = "role_id";
  
  final AuthRoutes route;
  
  AuthRequest({ required this.route });
  
  
  @override
  // TODO: implement url
  String get url {
    switch (route) {
      case AuthRoutes.login:
      return Constants.API_Auth_login_Controller;
      case AuthRoutes.logout:
      return Constants.API_Auth_logout_Controller;
      case AuthRoutes.profile:
      return Constants.API_Auth_profile_Controller;
      case AuthRoutes.updateProfile:
      return Constants.API_Auth_updateProfile_Controller;
      case AuthRoutes.updateFCM:
      return Constants.API_Auth_updateFCM_Controller;
    }
  }
  
  @override
  // TODO: implement params
  Map<String, dynamic> get params {
    Map<String, dynamic> parameters = {};
    switch (route) {
      case AuthRoutes.login:
      parameters[_paramKey_email] = email;
      parameters[_paramKey_password] = password;
      break;
      case AuthRoutes.logout:
      break;
      case AuthRoutes.profile:
      break;
      case AuthRoutes.updateProfile:
      parameters[_paramKey_first_name] = first_name;
      parameters[_paramKey_last_name] = last_name;
      parameters[_paramKey_email] = email;
      parameters[_paramKey_password] = password;
      parameters[_paramKey_mobile] = mobile;
      parameters[_paramKey_company_name] = company_name;
      parameters[_paramKey_user_type] = user_type;
      parameters[_paramKey_account_type] = account_type;
      break;
      case AuthRoutes.updateFCM:
      break;
    }
    return parameters;
  }
  
  @override
  // TODO: implement type
  HttpMethods get type {
    switch (route) {
      case AuthRoutes.login:
      return HttpMethods.post;
      case AuthRoutes.logout:
      return HttpMethods.post;
      case AuthRoutes.profile:
      return HttpMethods.get;
      case AuthRoutes.updateProfile:
      return HttpMethods.put;
      case AuthRoutes.updateFCM:
      return HttpMethods.post;
    }
  }
  
  @override
  // TODO: implement files
  List<BaseRequestFile> get files {
    final List<BaseRequestFile> list = [];
    switch (route) {
      case AuthRoutes.login:
      break;
      case AuthRoutes.logout:
      break;
      case AuthRoutes.profile:
      break;
      case AuthRoutes.updateProfile:
        // list.add(BaseRequestFile(data: data, parameterName: parameterName, fileName: fileName, mimiType: mimiType))
      break;
      case AuthRoutes.updateFCM:
      break;
    }
    return list;
  }
}

//************************* Jsonify *************************/
