// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/features/trailers/domain/entities/movie.dart';
import 'package:movie_trailer/features/trailers/presentation/widgets/custom_scrollbar.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';
import 'package:movie_trailer/helpers/screen_template.dart';
import 'package:movie_trailer/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'store/movie_video_store.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late MovieVideoStore movieVideoStore;
  @override
  void initState() {
    movieVideoStore = getIt<MovieVideoStore>();
    movieVideoStore.getVideoPath(widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return ScreenTemplate(
      appBar: AppBar(
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              widget.movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: xSSmallTextSize,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Image.network(
                    widget.movie.posterPath!,
                    width: 0.35.sw,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: TextStyle(
                        fontSize: xSmallTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text('Release Date: ${widget.movie.releaseDate}'),
                    Text('For Adult: ${widget.movie.adult}'),
                    Text('Popularity: ${widget.movie.popularity}'),
                    Text('Vote Count: ${widget.movie.voteCount}'),
                    Text('Vote Average: ${widget.movie.voteAverage}')
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: CustomScrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Text(
                        widget.movie.overview,
                      ),
                      SizedBox(height: 20.h),
                      Observer(builder: (context) {
                        return movieVideoStore.videoUrl != null
                            ? YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: movieVideoStore.videoUrl!,
                                    flags: YoutubePlayerFlags(
                                      autoPlay: false,
                                      mute: false,
                                    ),
                                  ),
                                ),
                                builder: (context, player) {
                                  return Column(
                                    children: [
                                      // some widgets
                                      player,
                                    ],
                                  );
                                })
                            : Container();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
