abstract class Movie {
  late bool adult;
  String? backdropPath;
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late num popularity;
  String? posterPath;
  late String releaseDate;
  late String title;
  late int voteCount;
  late bool video;
  late num voteAverage;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });
}
