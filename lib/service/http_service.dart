import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesapp/models/app_config.dart';

// this class is responsable for making requests to the API.

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  //config keys for sending http request
  String _base_url;
  String _api_key;

  // after empty object is constructed initialize it with data from _setup function in splash screen
  HTTPService() {
    // this line creates _app_config object from _setup function in splash screen
    AppConfig _app_config = getIt.get<AppConfig>();

    _base_url = _app_config.BASE_API_URL;
    _api_key = _app_config.API_KEY;
  }

  // Path variable is everything that comes after base url, and before qurey
  Future<Response> get(String _path, {Map<String, dynamic> query}) async {
    try {
      String _url = '$_base_url/$_path';
      Map<String, dynamic> _query = {
        'api_key': _api_key,
        'language': 'en-US',
      };

      // check if query is null, and then add it to map
      if (query != null) {
        _query.addAll(query);
      }

      // send request
      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print('Unable to perform get request.');
      print('DioError: $e');
    }
  }
}
