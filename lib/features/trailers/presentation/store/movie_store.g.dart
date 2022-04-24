// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieStore on MovieStoreBase, Store {
  late final _$busyAtom = Atom(name: 'MovieStoreBase.busy', context: context);

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  late final _$topRatedMoviesAtom =
      Atom(name: 'MovieStoreBase.topRatedMovies', context: context);

  @override
  ObservableList<Movie> get topRatedMovies {
    _$topRatedMoviesAtom.reportRead();
    return super.topRatedMovies;
  }

  @override
  set topRatedMovies(ObservableList<Movie> value) {
    _$topRatedMoviesAtom.reportWrite(value, super.topRatedMovies, () {
      super.topRatedMovies = value;
    });
  }

  late final _$latestMoviesAtom =
      Atom(name: 'MovieStoreBase.latestMovies', context: context);

  @override
  List<Movie>? get latestMovies {
    _$latestMoviesAtom.reportRead();
    return super.latestMovies;
  }

  @override
  set latestMovies(List<Movie>? value) {
    _$latestMoviesAtom.reportWrite(value, super.latestMovies, () {
      super.latestMovies = value;
    });
  }

  late final _$nowPlayingMoviesAtom =
      Atom(name: 'MovieStoreBase.nowPlayingMovies', context: context);

  @override
  List<Movie>? get nowPlayingMovies {
    _$nowPlayingMoviesAtom.reportRead();
    return super.nowPlayingMovies;
  }

  @override
  set nowPlayingMovies(List<Movie>? value) {
    _$nowPlayingMoviesAtom.reportWrite(value, super.nowPlayingMovies, () {
      super.nowPlayingMovies = value;
    });
  }

  late final _$upComingMoviesAtom =
      Atom(name: 'MovieStoreBase.upComingMovies', context: context);

  @override
  List<Movie>? get upComingMovies {
    _$upComingMoviesAtom.reportRead();
    return super.upComingMovies;
  }

  @override
  set upComingMovies(List<Movie>? value) {
    _$upComingMoviesAtom.reportWrite(value, super.upComingMovies, () {
      super.upComingMovies = value;
    });
  }

  late final _$fetchMovieListByTypeAsyncAction =
      AsyncAction('MovieStoreBase.fetchMovieListByType', context: context);

  @override
  Future<void> fetchMovieListByType(
      {MovieType movieType = MovieType.TopRated}) {
    return _$fetchMovieListByTypeAsyncAction
        .run(() => super.fetchMovieListByType(movieType: movieType));
  }

  late final _$MovieStoreBaseActionController =
      ActionController(name: 'MovieStoreBase', context: context);

  @override
  void setBusy(dynamic _busy) {
    final _$actionInfo = _$MovieStoreBaseActionController.startAction(
        name: 'MovieStoreBase.setBusy');
    try {
      return super.setBusy(_busy);
    } finally {
      _$MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchWithFilter() {
    final _$actionInfo = _$MovieStoreBaseActionController.startAction(
        name: 'MovieStoreBase.fetchWithFilter');
    try {
      return super.fetchWithFilter();
    } finally {
      _$MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
busy: ${busy},
topRatedMovies: ${topRatedMovies},
latestMovies: ${latestMovies},
nowPlayingMovies: ${nowPlayingMovies},
upComingMovies: ${upComingMovies}
    ''';
  }
}
