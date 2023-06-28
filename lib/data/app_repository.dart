import 'package:movie_apps/data/app_services.dart';
import 'package:movie_apps/models/detail_movie_model.dart';
import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/models/response_model.dart';

class AppRepository {
  final AppServices services;

  AppRepository({required this.services});

  Future<ListResponse<Movie>> getNowPlayingMovies() async {
    return services.getNowPlayingMovies();
  }

  Future<ListResponse<Movie>> getPopularMovies() async {
    return services.getPopularMovies();
  }

  Future<ListResponse<Movie>> getUpcomingMovies() async {
    return services.getUpcomingMovies();
  }

  Future<SingleResponse<DetailMovie>> getDetailMovie({required int id}) async {
    return services.getDetailMovie(id: id);
  }
}
