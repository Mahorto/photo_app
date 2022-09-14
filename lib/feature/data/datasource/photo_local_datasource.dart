import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_app/core/error/exception.dart';
import 'package:photo_app/feature/data/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PhotoLocalDatasource {
  Future<List<PhotoModel>> getLastPhotosFromCache();
  Future<void> photosToCahce(List<PhotoModel> photos);
}

const String keyCacheStringList = 'CA_PHOTO_LIST';

class PhotoLocalDatasourceImplements implements PhotoLocalDatasource {
  final SharedPreferences sharedPreferences;

  PhotoLocalDatasourceImplements({required this.sharedPreferences});

  @override
  Future<List<PhotoModel>> getLastPhotosFromCache() {
    final jsonPhotosList = sharedPreferences.getStringList(keyCacheStringList);
    if (jsonPhotosList != null) {
      if (jsonPhotosList.isNotEmpty) {
        return Future.value(jsonPhotosList
            .map((photo) => PhotoModel.fromJson(json.decode(photo)))
            .toList());
      } else {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> photosToCahce(List<PhotoModel> photos) {
    final List<String> jsonPhotosList =
        photos.map((photo) => json.encode(photo.toJson())).toList();

    sharedPreferences.setStringList(keyCacheStringList, jsonPhotosList);
    print('Cahce: ${jsonPhotosList.length}');
    return Future.value(jsonPhotosList);
  }
}
