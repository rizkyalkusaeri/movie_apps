import 'package:movie_apps/data/app_services.dart';
import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/models/response_model.dart';

class AppRepository {
  final AppServices services;

  AppRepository({required this.services});

  Future<ListResponse<Movie>> getNowPlayingMovies() async {
    return services.getNowPlayingMovies();
  }
}
