import 'package:mobx/mobx.dart';
import 'package:movie_trailer/features/trailer_detail/domain/use_case/movie_video_use_case.dart';
import 'package:movie_trailer/main.dart';

part 'movie_video_store.g.dart';

class MovieVideoStore = MovieVideoStoreBase with _$MovieVideoStore;

abstract class MovieVideoStoreBase with Store {
  final MovieVideoUseCase movieVideoUseCase = getIt<MovieVideoUseCase>();

  @observable
  String? videoUrl;

  @action
  Future<void> getVideoPath(int id) async {
    videoUrl = null;
    var movieVideo = await movieVideoUseCase.fetchMovieVideo(id: id);
    videoUrl = movieVideo!.key;
  }
}
