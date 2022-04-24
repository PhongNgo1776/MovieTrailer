import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'core/constants/route_paths.dart';
import 'core/services/network_service.dart';
import 'features/trailer_detail/data/repositories/movie_video_repository_impl.dart';
import 'features/trailer_detail/domain/use_case/movie_video_use_case.dart';
import 'features/trailer_detail/presentation/detail_screen.dart';
import 'features/trailer_detail/presentation/store/movie_video_store.dart';
import 'features/trailers/data/repositories/movie_repository_impl.dart';
import 'features/trailers/domain/entities/movie.dart';
import 'features/trailers/domain/use_cases/movie_use_case.dart';
import 'features/trailers/presentation/screens/home/home_screen.dart';
import 'features/trailers/presentation/screens/splash_screen.dart';
import 'features/trailers/presentation/store/movie_store.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerLazySingleton(() => NetworkService());

  getIt.registerLazySingleton(() => MovieRepositoryImpl());
  getIt.registerLazySingleton(() => MovieUseCase());
  getIt.registerSingleton<MovieStore>(MovieStore());

  getIt.registerLazySingleton(() => MovieVideoRepositoryImpl());
  getIt.registerLazySingleton(() => MovieVideoUseCase());
  getIt.registerSingleton<MovieVideoStore>(MovieVideoStore());
}

main() {
  setup();
  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      builder: () => MaterialApp(
        title: 'Movie Trailer',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.blue,
          ),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case RoutePaths.home:
              return ScaleRoute(widget: HomeScreen(), settings: settings);
            case RoutePaths.detail:
              var movie = settings.arguments as Movie;
              final movieDetail = DetailScreen(
                movie: movie,
              );
              return MaterialPageRoute(
                  settings: settings, builder: (context) => movieDetail);
            default:
              return ScaleRoute(widget: HomeScreen(), settings: settings);
          }
        },
      ),
    ),
  );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings settings;
  ScaleRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> animation2,
          ) =>
              widget,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> animation2,
            Widget widget,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.bounceInOut,
              ),
            ),
            child: widget,
          ),
        );
}
