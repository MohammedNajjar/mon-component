///************************* Jsonify *************************/
/// Created by Jsonify
import 'package:flutter/foundation.dart';
import 'package:mon/model/database_manager.dart';
import 'package:sqflite/sqflite.dart';
// TUser class



class TUser {

  static const tableName = "users";
  static const primaryKey = "_id";

  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? avatar;
  bool? isActive;



  TUser();

  TUser.fromJson(Map<String, dynamic>? json) {
    id = json?['_id'] as String?;
    firstName = json?['first_name'] as String?;
    lastName = json?['last_name'] as String?;
    fullName = json?['full_name'] as String?;
    email = json?['email'] as String?;
    avatar = json?['avatar'] as String?;
    if(json?['is_active'] is bool?) {
      isActive = json?['is_active'] as bool?;
    } else if(json?['is_active'] is int?) {
      isActive = (json?['is_active'] as int?) == 1 ? true : false;
    }
  }

  Future<void> fromJsonToDataBase(Map<String, dynamic>? json) async {
    id = json?['_id'] as String?;
    firstName = json?['first_name'] as String?;
    lastName = json?['last_name'] as String?;
    fullName = json?['full_name'] as String?;
    email = json?['email'] as String?;
    avatar = json?['avatar'] as String?;
    isActive = json?['is_active'] as bool?;
    await dbInsertQuery();
  }

  static String dbCreation() {
    return '''
    CREATE TABLE IF NOT EXISTS ${ TUser.tableName } (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    _id TEXT UNIQUE,
    first_name TEXT NULL,
    last_name TEXT NULL,
    full_name TEXT NULL,
    email TEXT NULL,
    avatar TEXT NULL,
    is_active INTEGER NULL
    )
    ''';
  }

  Future<void> dbInsertQuery() async {
    await DatabaseManager.shared.insertOrUpdate(TUser.tableName, toDatabaseInsertion(), primaryKey: TUser.primaryKey);
  }

  static String dbQuery(String? id) {
    return id != null ? "SELECT * FROM ${ TUser.tableName } WHERE _id = ${id!}" :  "SELECT * FROM ${ TUser.tableName }";
  }

  Map<String, dynamic> toDatabaseInsertion() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['full_name'] = fullName;
    json['email'] = email;
    json['avatar'] = avatar;
    json['is_active'] = isActive != null ?  (isActive! ? 1 : 0) : 0;
    json.removeWhere((key, value) => value == null || value == '');
    return json;
  }

  static Future<List<Map<String, dynamic>>> getAll({String query = ""}) async {
    final objects = await DatabaseManager.shared.rawQuery('SELECT * FROM ${ TUser.tableName }${ query.isNotEmpty ? " $query" : "" }');
    final relatedObjects = <String, List<Map<String, dynamic>>>{};
    for (final object in objects) {
    }

    final nestedObjects = <Map<String, dynamic>>[];
    for (final object in objects) {

      final nestedObject = {
        ...object
      };

      nestedObjects.add(nestedObject);
    }

    return nestedObjects;
  }

  @override
  String toString() {
    return '''TUser{
      id: $id,
      firstName: $firstName,
      lastName: $lastName,
      fullName: $fullName,
      email: $email,
      avatar: $avatar,
      isActive: $isActive,
    }''';
  }

  static List<TUser> fromJsonList(dynamic json) {
    if (json is List) {
      return json.map((item) => TUser.fromJson(item)).toList();
    } else if (json is Map) {
      return [TUser.fromJson(json as Map<String, dynamic>?)];
    } else {
      return [TUser.fromJson(json as Map<String, dynamic>?)];
    }
  }

  static Future<List<TUser>> fromJsonToLocalDatabaseList(dynamic json) async {
    List<TUser> list = [];
    if (json is List) {
      for (var js in json) {
        final object = TUser();
        await object.fromJsonToDataBase(js);
        list.add(object);
      }
    } else {
      final object = TUser();
      await object.fromJsonToDataBase(json as Map<String, dynamic>?);
      list.add(object);
    }
    return list;
  }
}


///************************* Jsonify *************************/
