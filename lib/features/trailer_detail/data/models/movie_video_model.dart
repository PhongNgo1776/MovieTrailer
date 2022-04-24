import 'package:movie_trailer/features/trailer_detail/domain/entities/movie_video.dart';

class MovieVideoModel extends MovieVideo {
  MovieVideoModel({
    required String key,
  }) : super(
          key: key,
        );

  factory MovieVideoModel.fromJson(dynamic json) => MovieVideoModel(
        key: json['key'],
      );
}
