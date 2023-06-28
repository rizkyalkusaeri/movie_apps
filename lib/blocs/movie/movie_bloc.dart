import 'dart:async';
import 'package:movie_apps/blocs/movie/movie_event.dart';
import 'package:movie_apps/blocs/movie/movie_state.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required this.repository,
  }) : super(const MovieState()) {
    on<GetMovies>(_mapGetMoviesEventToState);
  }

  final AppRepository repository;

  FutureOr<void> _mapGetMoviesEventToState(
    GetMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.initial));

    try {
      var resNowPlayingMovies = await repository.getNowPlayingMovies();
      var resPopularMovies = await repository.getPopularMovies();
      var resUpcomingMovies = await repository.getUpcomingMovies();
      // if (kDebugMode) {
      //   print(resNowPlayingMovies.message);
      // }

      var resMessage =
          '${resNowPlayingMovies.message ?? ''}${resPopularMovies.message ?? ''}${resUpcomingMovies.message ?? ''}';

      emit(state.copyWith(
        listNowPlayingMovies: resNowPlayingMovies.results,
        listPopularMovies: resPopularMovies.results,
        listUpcomingMovies: resUpcomingMovies.results,
        message: resMessage,
        status: resMessage.isNotEmpty ? StateStatus.error : StateStatus.success,
      ));
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(
        state.copyWith(status: StateStatus.error, message: e.toString()),
      );
    }
  }
}
