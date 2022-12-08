import 'dart:convert';

import 'package:flutter_api_call/api/config/api_constant.dart';
import 'package:flutter_api_call/api/config/api_helper.dart';
import 'package:flutter_api_call/api/user/model/user_model.dart';

class UserRepository {
  static Future<List<User>> fetchUserList() async {
    // await Future.delayed(const Duration(seconds: 2));
    final response = await ApiHelper().get(url: 'users');
    if (response != null) {
      final userList = <User>[];
      for (var item in response) {
        userList.add(User.fromJson(item));
      }
      return userList;
    } else {
      return [];
    }
  }

  static Future<User?> fetchUser({required id}) async {
    // await Future.delayed(const Duration(seconds: 2));
    final response = await ApiHelper().get(url: 'users/$id');
    if (response != null) {
      return User.fromJson(response);
    } else {
      return null;
    }
  }

  static Future<User?> addUser({required User user}) async {
    await Future.delayed(const Duration(seconds: 2));
    User? returnResponse;
    final response = await ApiHelper().post(
        url: 'ausers', header: ApiConstant.header, body: jsonEncode(user));
    if (response != null) {
      returnResponse = User.fromJson(response);
      return returnResponse;
    } else {
      return returnResponse;
    }
  }
}
