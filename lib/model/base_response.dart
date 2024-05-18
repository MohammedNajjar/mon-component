import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/utils/mbmanager.dart';
import 'package:dio/dio.dart';

 class BaseResponse {
  bool? status;

  String? message;

  int? code;

  dynamic data;

  Pagination? pagination;

  Map<String, dynamic>? json;

  BaseResponse({  this.pagination, this.status,  this.code,  this.data,  this.message });

  bool getResponseStatus(Response? res) {
    return (status == true) && ((res?.statusCode == 200) || (res?.statusCode == 201));
  }

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    code = json['code'] as int;
    message = json['message'] as String;
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    data = json['data'];
    this.json = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (pagination != null) {
      data['pagination'] = pagination?.toJson();
    }
    return data;
  }
 }

 class Pagination {

   num? totalPages;

   num? totalItems;

   num? itemsPerPage;

   num? currentPage;

   Pagination({  this.totalPages,  this.totalItems,  this.itemsPerPage,  this.currentPage });

   Pagination.fromJson(Map<String, dynamic> json) {
     totalPages = numParse(json['total_pages']);
     totalItems = numParse(json['total_items']);
     itemsPerPage = numParse(json['items_per_page']);
     currentPage = numParse(json['current_page']);
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = {};
     data['total_pages'] = totalPages;
     data['total_items'] = totalItems;
     data['items_per_page'] = itemsPerPage;
     data['current_page'] = currentPage;
     return data;
   }
 }
 