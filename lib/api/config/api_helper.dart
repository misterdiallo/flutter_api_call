// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_constant.dart';
import 'api_exception.dart';

class ApiHelper {
  final String _baseUrl = ApiConstant.url;
  Future<dynamic> get({required String url, header}) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(
      {required String url, required body, required header}) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: header, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
