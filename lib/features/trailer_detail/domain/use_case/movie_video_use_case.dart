import 'package:movie_trailer/features/trailer_detail/data/repositories/movie_video_repository_impl.dart';
import 'package:movie_trailer/features/trailer_detail/domain/entities/movie_video.dart';
import 'package:movie_trailer/features/trailer_detail/domain/repositories/movie_video_repository.dart';
import 'package:movie_trailer/main.dart';

class MovieVideoUseCase {
  late MovieVideoRepository movieVideoRepository;

  MovieVideoUseCase() {
    this.movieVideoRepository = getIt<MovieVideoRepositoryImpl>();
  }

  Future<MovieVideo?> fetchMovieVideo({required int id}) async {
    return await movieVideoRepository.fetchVideoKey(id: id);
  }
}
