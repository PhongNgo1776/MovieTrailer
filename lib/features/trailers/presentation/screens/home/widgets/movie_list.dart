import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/core/enum/movie_type.dart';
import 'package:movie_trailer/features/trailers/presentation/store/movie_store.dart';
import 'package:movie_trailer/main.dart';

import '../../../widgets/custom_scrollbar.dart';
import 'movie_row.dart';

class MovieList extends StatelessWidget {
  MovieList({
    Key? key,
    required this.scrollController,
    this.needHorizontalPadding = true,
    this.allowMoveToUserScreen = true,
    required this.movieType,
  }) : super(key: key);

  final MovieType movieType;
  final ScrollController scrollController;
  final bool needHorizontalPadding;
  final bool allowMoveToUserScreen;

  @override
  Widget build(BuildContext context) {
    MovieStore movieStore = getIt<MovieStore>();

    return CustomScrollbar(
      controller: scrollController,
      child: Observer(builder: (context) {
        return ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: ((movieStore.topRatedMovies.length) / 2).ceil(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: needHorizontalPadding ? 10.w : 0),
                child: MovieRow(
                  movieList: movieStore.topRatedMovies,
                  rowIndex: index,
                ),
              );
            });
      }),
    );
  }
}
