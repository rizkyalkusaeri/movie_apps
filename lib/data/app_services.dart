// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/models/response_model.dart';

const BASE_URL = 'https://api.themoviedb.org/3';

class AppServices {
  final Client _httpClient;

  AppServices({
    // this.plant = PLANT,

    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Uri getUrl({
    required String url,
    Map<String, dynamic>? extraParameters,
  }) {
    final queryParameters = <String, dynamic>{
      'api_key': '98885347f66eed501f91428fcd71ad26'
    };

    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$BASE_URL/$url').replace(
      queryParameters: queryParameters,
    );
  }

  Future<ListResponse<Movie>> getNowPlayingMovies() async {
    final response = await _httpClient.get(getUrl(url: '/movie/now_playing'));

    var jsonObject = jsonDecode(response.body);

    return ListResponse.fromJson(
      json: jsonObject,
      fromJsonModel: Movie.fromJson,
    );
  }
}
