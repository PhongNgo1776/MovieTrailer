import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_trailer/core/enum/movie_type.dart';
import 'package:movie_trailer/core/utils/utils.dart';
import 'package:movie_trailer/features/trailers/presentation/store/movie_store.dart';
import 'package:movie_trailer/main.dart';

import 'loading_layer.dart';
import 'movie_list.dart';

const BOTTOM_NAVIGATION_HEIGHT = 50.0;

class MovieBodyTab extends StatefulWidget {
  final MovieType movieType;
  final TabController tabController;
  final ScrollController parentScrollCtrl;

  const MovieBodyTab({
    Key? key,
    required this.movieType,
    required this.tabController,
    required this.parentScrollCtrl,
  }) : super(key: key);
  @override
  _MovieBodyTabState createState() => _MovieBodyTabState();
}

class _MovieBodyTabState extends State<MovieBodyTab> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        MovieTab(
          movieType: MovieType.TopRated,
          parentScrollCtrl: widget.parentScrollCtrl,
        ),
        MovieTab(
          movieType: MovieType.Latest,
          parentScrollCtrl: widget.parentScrollCtrl,
        ),
        MovieTab(
          movieType: MovieType.NowPlaying,
          parentScrollCtrl: widget.parentScrollCtrl,
        ),
        MovieTab(
          movieType: MovieType.UpComing,
          parentScrollCtrl: widget.parentScrollCtrl,
        ),
      ],
      controller: widget.tabController,
    );
  }
}

class MovieTab extends StatefulWidget {
  const MovieTab({
    Key? key,
    required this.parentScrollCtrl,
    required this.movieType,
  }) : super(key: key);

  final MovieType movieType;
  final ScrollController parentScrollCtrl;

  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  late ScrollController scrollController;
  MovieStore movieStore = getIt<MovieStore>();

  @override
  void initState() {
    scrollController = ScrollController();
    runAfterDurationZero(
      () => movieStore.fetchMovieListByType(movieType: widget.movieType),
    );

    setScrollEvent(
      scrollController: scrollController,
      movieStore: movieStore,
      onScrollUp: () => scrollParentScrollCtrl(0),
      onsScrollDown: () {
        var maxParentScrollPx =
            widget.parentScrollCtrl.position.maxScrollExtent;
        scrollParentScrollCtrl(maxParentScrollPx);
      },
      onLoadMore: () {
        movieStore.fetchMovieListByType(movieType: widget.movieType);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height - BOTTOM_NAVIGATION_HEIGHT.h,
          child: MovieList(
            scrollController: scrollController,
            movieType: widget.movieType,
          ),
        ),
        LoadingLayer()
      ],
    );
  }

  void scrollParentScrollCtrl(double positionPixel) {
    widget.parentScrollCtrl.animateTo(
      positionPixel,
      curve: Curves.ease,
      duration: kTabScrollDuration,
    );
  }

  void setScrollEvent({
    ScrollController? scrollController,
    required MovieStore movieStore,
    VoidCallback? onLoadMore,
    VoidCallback? onsScrollDown,
    VoidCallback? onScrollUp,
  }) {
    scrollController!.addListener(() {
      var scrollPosition = scrollController.position;
      var maxScrollPx = scrollPosition.maxScrollExtent;
      var currentScrollPx = scrollPosition.pixels;
      var downDirection = scrollController.position.userScrollDirection ==
          ScrollDirection.reverse;

      if (downDirection) {
        if (onsScrollDown != null) onsScrollDown();
        if (currentScrollPx >= maxScrollPx * 0.8 && !movieStore.busy) {
          if (onLoadMore != null) onLoadMore();
        }
      } else {
        if (onScrollUp != null) onScrollUp();
      }
    });
  }
}
