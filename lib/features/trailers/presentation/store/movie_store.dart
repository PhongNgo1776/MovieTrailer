import 'dart:async';

import 'package:devicelocale/devicelocale.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_trailer/core/enum/movie_type.dart';
import 'package:movie_trailer/core/services/network_service.dart';
import 'package:movie_trailer/features/trailers/domain/entities/movie.dart';
import 'package:movie_trailer/features/trailers/domain/use_cases/movie_use_case.dart';
import 'package:movie_trailer/main.dart';

part 'movie_store.g.dart';

class MovieStore = MovieStoreBase with _$MovieStore;

abstract class MovieStoreBase with Store {
  final MovieUseCase movieUseCase = getIt<MovieUseCase>();
  final NetworkService networkService = getIt<NetworkService>();
  late String currentLocale;
  final Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 100));

  @observable
  bool busy = false;

  @action
  void setBusy(_busy) => busy = _busy;

  @observable
  ObservableList<Movie> topRatedMovies = ObservableList<Movie>();

  @observable
  List<Movie>? latestMovies = <Movie>[];

  @observable
  List<Movie>? nowPlayingMovies = <Movie>[];

  @observable
  List<Movie>? upComingMovies = <Movie>[];

  String? from;
  String? to;

  // @action
  // void addLatestMovies(List<Movie> newMovies) =>
  //     latestMovies!.addAll(newMovies);

  // @action
  // void addNowPlayingMovies(List<Movie> newMovies) =>
  //     nowPlayingMovies!.addAll(newMovies);

  // @action
  // void addUpComingMovies(List<Movie> newMovies) =>
  //     upComingMovies!.addAll(newMovies);

  int topRatedPage = 1;
  int latestPage = 1;
  int nowPlayingPage = 1;
  int upComingPage = 1;

  @action
  void fetchWithFilter() {
    topRatedMovies.clear();
    topRatedPage = 1;
    fetchMovieListByType();
  }

  @action
  Future<void> fetchMovieListByType({
    MovieType movieType = MovieType.TopRated,
  }) async {
    debouncer.call(() async {
      setBusy(true);
      var newMovies = await movieUseCase.fetchTopRatedMovies(
        locale: currentLocale,
        page: topRatedPage,
        from: from,
        to: to,
      );

      if (newMovies!.isNotEmpty) {
        topRatedMovies.addAll(newMovies);
        topRatedPage += 1;
      }

      setBusy(false);
    });
  }

  int getPageByType(MovieType movieType) {
    switch (movieType) {
      case MovieType.TopRated:
        return topRatedPage;
      case MovieType.Latest:
        return latestPage;
      case MovieType.NowPlaying:
        return nowPlayingPage;
      case MovieType.UpComing:
        return upComingPage;
      default:
        return topRatedPage;
    }
  }

  void init() {
    checkLocale();
    networkService.checkConnection();
    networkService.counterStream.listen((_) {
      Future.delayed(Duration(seconds: 5), () {
        if (topRatedMovies.isEmpty && !busy) {
          fetchMovieListByType();
        }
      });
    });
  }

  Future<void> checkLocale() async {
    try {
      currentLocale =
          (await Devicelocale.currentLocale)!.replaceFirst('_', '-');
    } catch (e) {
      print("Error obtaining current locale");
    }
  }
}
