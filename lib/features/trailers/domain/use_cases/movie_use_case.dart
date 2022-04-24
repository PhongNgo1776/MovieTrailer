
import 'package:movie_trailer/features/trailers/domain/entities/movie.dart';
import 'package:movie_trailer/main.dart';

import '../../data/repositories/movie_repository_impl.dart';
import '../repositories/movie_repository.dart';

class MovieUseCase {
  late MovieRepository movieRepository;

  MovieUseCase() {
    this.movieRepository = getIt<MovieRepositoryImpl>();
  }

  Future<List<Movie>?> fetchTopRatedMovies({
    String locale = 'en-US',
    int page = 1,
    String? from,
    String? to,
  }) async {
    return await movieRepository.fetchTopRatedMovies(
      locale: locale,
      page: page,
      from: from,
      to: to,
    );
  }
}
