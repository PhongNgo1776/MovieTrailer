import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/core/constants/route_paths.dart';
import 'package:movie_trailer/features/trailers/domain/entities/movie.dart';

class MovieRow extends StatelessWidget {
  const MovieRow({
    Key? key,
    required this.rowIndex,
    required this.movieList,
  }) : super(key: key);

  final int rowIndex;
  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    var index = rowIndex * 2;
    var leftIndex = index;
    var rightIndex = index + 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        getMovieItem(context: context, itemIndex: leftIndex),
        SizedBox(width: 10),
        getMovieItem(context: context, itemIndex: rightIndex),
      ],
    );
  }

  Widget getMovieItem({
    required BuildContext context,
    required int itemIndex,
  }) {
    if (itemIndex < movieList.length) {
      var movie = movieList[itemIndex];
      return InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          RoutePaths.detail,
          arguments: movie,
        ),
        child: Container(
          width: 0.45.sw,
          height: 0.6.sw,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.w),
          ),
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(movie.posterPath!),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
