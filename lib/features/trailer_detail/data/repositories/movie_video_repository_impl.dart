import 'dart:convert';

import 'package:movie_trailer/core/constants/constants.dart';
import 'package:movie_trailer/features/trailer_detail/data/models/movie_video_model.dart';
import 'package:movie_trailer/features/trailer_detail/domain/entities/movie_video.dart';
import 'package:movie_trailer/features/trailer_detail/domain/repositories/movie_video_repository.dart';
import 'package:http/http.dart' as http;

class MovieVideoRepositoryImpl extends MovieVideoRepository {
  @override
  Future<MovieVideo?> fetchVideoKey({required int id}) async {
    var movieList;
    try {
      var url =
          Uri.https(HOST_URL, '/3/movie/$id/videos', {'api_key': API_KEY});

      var jsonData = await http.read(url);
      var rawMovieList = json.decode(jsonData)['results'] as List<dynamic>;
      movieList = rawMovieList.map((e) => MovieVideoModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return movieList.isNotEmpty ? movieList[0] : null;
  }
}
