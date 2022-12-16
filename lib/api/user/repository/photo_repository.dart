import 'dart:convert';

import 'package:flutter_api_call/api/config/api_constant.dart';
import 'package:flutter_api_call/api/config/api_helper.dart';
import 'package:flutter_api_call/api/user/model/photo_model.dart';

class PhotoRepository {
  static Future<List<Photo>> getAllphotos() async {
    // await Future.delayed(const Duration(seconds: 2));
    final response = await ApiHelper().getAndSearch(url: 'photos');
    if (response != null) {
      final photoList = <Photo>[];
      for (var item in response) {
        photoList.add(Photo.fromJson(item));
      }
      return photoList;
    } else {
      return [];
    }
  }

  static Future<Photo?> getOnePhoto({required id}) async {
    // await Future.delayed(const Duration(seconds: 2));
    final response = await ApiHelper().getAndSearch(url: 'photos/$id');
    if (response != null) {
      return Photo.fromJson(response);
    } else {
      return null;
    }
  }

  static Future<Photo?> createPhoto({required Photo photo}) async {
    // await Future.delayed(const Duration(seconds: 2));
    Photo? returnResponse;
    final response = await ApiHelper().post(
        url: 'photos', header: ApiConstant.header, body: jsonEncode(photo));
    if (response != null) {
      returnResponse = Photo.fromJson(response);
      return returnResponse;
    } else {
      return returnResponse;
    }
  }

  static Future<Photo?> updatePhoto({required Photo photo, required id}) async {
    // await Future.delayed(const Duration(seconds: 2));
    Photo? returnResponse;
    final response = await ApiHelper().put(
        url: 'photos/$id', header: ApiConstant.header, body: jsonEncode(photo));
    if (response != null) {
      returnResponse = Photo.fromJson(response);
      return returnResponse;
    } else {
      return returnResponse;
    }
  }

  static Future<Photo?> deletePhoto({required Photo photo, required id}) async {
    // await Future.delayed(const Duration(seconds: 2));
    Photo? returnResponse;
    final response = await ApiHelper().delete(
      url: 'photos/$id',
      header: ApiConstant.header,
    );
    if (response != null) {
      returnResponse = response;
      return returnResponse;
    } else {
      return returnResponse;
    }
  }

  static Future<List<Photo>> searchPhoto(
      {required String type, required keyword}) async {
    // await Future.delayed(const Duration(seconds: 2));
    final response =
        await ApiHelper().getAndSearch(url: 'photos?$type=$keyword');
    if (response != null) {
      final photoList = <Photo>[];
      for (var item in response) {
        photoList.add(Photo.fromJson(item));
      }
      return photoList;
    } else {
      return [];
    }
  }
}
