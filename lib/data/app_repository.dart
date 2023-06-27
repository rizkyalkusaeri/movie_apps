import 'package:movie_apps/data/app_services.dart';

class AppRepository {
  final AppServices services;

  AppRepository({required this.services});

  getNowPlayingMovies() async {
    return services.getNowPlayingMovies();
  }
}
