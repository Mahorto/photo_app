import 'dart:convert';
import 'dart:io';
import 'package:photo_app/core/error/exception.dart';
import 'package:photo_app/feature/data/models/photo_model.dart';
import 'package:http/http.dart' as http;

abstract class PhotoDatasource {
  Future<List<PhotoModel>> getAllPhotos(int page);
}

class PhotoDatasourceImplement implements PhotoDatasource {
  final http.Client client;

  PhotoDatasourceImplement({required this.client});
  @override
  Future<List<PhotoModel>> getAllPhotos(int page) async =>
      _getPhotoFromUrl('&page=$page&per_page=${page + 35}');

  Future<List<PhotoModel>> _getPhotoFromUrl(String url) async {
    print(_getPhotoAPIUrl(url));
    final response = await client.get(Uri.parse(_getPhotoAPIUrl(url)),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final photos = json.decode(response.body);
      var res =
          (photos as List).map((photo) => PhotoModel.fromJson(photo)).toList();

      return res;
    } else {
      throw ServerException();
    }
  }

  String _getPhotoAPIUrl(String param) {
    const String mainUrl = 'http://api.unsplash.com';
    const String path = '/photos';
    const String apiKey =
        '?client_id=896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043';
    return '$mainUrl$path/$apiKey$param';
  }
}
