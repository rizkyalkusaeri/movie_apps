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
      var response = await repository.getNowPlayingMovies();
      if (kDebugMode) {
        print(response.message);
      }
      emit(state.copyWith(
        message: response.message,
        status: StateStatus.success,
        listData: response.data,
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
