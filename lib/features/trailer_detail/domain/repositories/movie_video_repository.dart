import 'package:movie_trailer/features/trailer_detail/domain/entities/movie_video.dart';

abstract class MovieVideoRepository {
  Future<MovieVideo?> fetchVideoKey({required int id});
}
