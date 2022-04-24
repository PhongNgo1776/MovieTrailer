import 'package:movie_trailer/features/trailers/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>?> fetchTopRatedMovies({
    String locale = 'en-US',
    int page = 1,
    String? from,
    String? to,
  });
}
