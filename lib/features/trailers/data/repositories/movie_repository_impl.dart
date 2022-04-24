import 'dart:convert';

import 'package:movie_trailer/core/constants/constants.dart';
import 'package:movie_trailer/features/trailers/data/models/movie_model.dart';

import '../../domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;

const TOP_RATED_PATH = '/3/movie/top_rated';

class MovieRepositoryImpl extends MovieRepository {
  List<MovieModel>? topRatedmovieList;

  Future<List<MovieModel>?> fetchTopRatedMovies({
    String locale = 'en-US',
    int page = 1,
    String? from,
    String? to,
  }) async {
    print('-----called page: ' + page.toString());
    var additionalParams = <String, String>{};
    if (from != null) {
      additionalParams['primary_release_date.gte'] = from;
    }

    if (to != null) {
      additionalParams['primary_release_date.lte'] = to;
    }

    topRatedmovieList = await fetchMovieList(
      path: TOP_RATED_PATH,
      queryParameters: getQueryParameters(
        locale: locale,
        page: page,
        additionalParams: additionalParams,
      ),
    );

    return topRatedmovieList;
  }

  Future<List<MovieModel>?> fetchMovieList({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    var movieList;
    try {
      var url = Uri.https(HOST_URL, path, queryParameters);

      var jsonData = await http.read(url);
      var rawMovieList = json.decode(jsonData)['results'] as List<dynamic>;
      movieList = rawMovieList.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return movieList;
  }

  Map<String, dynamic>? getQueryParameters({
    String locale = 'en-US',
    int page = 1,
    Map<String, String>? additionalParams,
  }) {
    var queryParameters = {
      'api_key': API_KEY,
      'language': locale,
      'page': '$page',
    };

    if (additionalParams != null) {
      queryParameters.addAll(additionalParams);
    }

    return queryParameters;
  }
}
