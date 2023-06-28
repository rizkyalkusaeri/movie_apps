import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final String message;
  final StateStatus status;
  final List<Movie> listNowPlayingMovies;
  final List<Movie> listPopularMovies;
  final List<Movie> listUpcomingMovies;

  const MovieState({
    this.message = '',
    this.status = StateStatus.initial,
    List<Movie>? listNowPlayingMovies,
    List<Movie>? listPopularMovies,
    List<Movie>? listUpcomingMovies,
  })  : listNowPlayingMovies = listNowPlayingMovies ?? const [],
        listPopularMovies = listPopularMovies ?? const [],
        listUpcomingMovies = listUpcomingMovies ?? const [];

  @override
  List<Object?> get props => [
        message,
        status,
        listNowPlayingMovies,
        listPopularMovies,
        listUpcomingMovies,
      ];

  MovieState copyWith({
    String? message,
    StateStatus? status,
    List<Movie>? listNowPlayingMovies,
    List<Movie>? listPopularMovies,
    List<Movie>? listUpcomingMovies,
  }) {
    return MovieState(
      status: status ?? this.status,
      message: message ?? this.message,
      listNowPlayingMovies: listNowPlayingMovies ?? this.listNowPlayingMovies,
      listPopularMovies: listPopularMovies ?? this.listPopularMovies,
      listUpcomingMovies: listUpcomingMovies ?? this.listUpcomingMovies,
    );
  }
}
