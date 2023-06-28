import 'dart:async';
import 'package:movie_apps/blocs/detail/detail_event.dart';
import 'package:movie_apps/blocs/detail/detail_state.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required this.repository,
  }) : super(const DetailState()) {
    on<GetDetailMovie>(_mapGetDetailMovieEventToState);
  }

  final AppRepository repository;

  FutureOr<void> _mapGetDetailMovieEventToState(
    GetDetailMovie event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.initial));

    try {
      var resDetailMovie = await repository.getDetailMovie(id: event.id);

      emit(state.copyWith(
        detailMovie: resDetailMovie.results,
        message: resDetailMovie.message,
        status: resDetailMovie.statusCode != 200
            ? StateStatus.error
            : StateStatus.success,
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
