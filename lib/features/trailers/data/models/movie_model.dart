import 'package:movie_trailer/core/constants/constants.dart';
import 'package:movie_trailer/features/trailers/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required bool adult,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required num popularity,
    required String releaseDate,
    required String title,
    required int voteCount,
    required bool video,
    required num voteAverage,
    String? backdropPath,
    String? posterPath,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          id: id,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          releaseDate: releaseDate,
          title: title,
          voteCount: voteCount,
          video: video,
          voteAverage: voteAverage,
        );

  factory MovieModel.fromJson(dynamic json) => MovieModel(
        adult: json['adult'],
        backdropPath: json['backdrop_path'] != null
            ? IMAGE_ROOT + json['backdrop_path']
            : '',
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath:
            json['poster_path'] != null ? IMAGE_ROOT + json['poster_path'] : '',
        releaseDate: json['release_date'],
        title: json['title'],
        voteCount: json['vote_count'],
        video: json['video'],
        voteAverage: json['vote_average'],
      );
}
