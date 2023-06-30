import 'dart:async';

import 'package:movie_apps/blocs/tv/tv_event.dart';
import 'package:movie_apps/blocs/tv/tv_state.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  TvBloc({
    required this.repository,
  }) : super(const TvState()) {
    on<GetTelevisions>(_mapGetTelevisionsEventToState);
  }

  final AppRepository repository;

  FutureOr<void> _mapGetTelevisionsEventToState(
    GetTelevisions event,
    Emitter<TvState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.initial));

    try {
      var resOnTheAirTv = await repository.getOnTheAirTv();
      var resPopularTv = await repository.getPopularTv();

      // if (kDebugMode) {
      //   print(resNowPlayingMovies.message);
      // }

      var resMessage =
          '${resOnTheAirTv.message ?? ''}${resPopularTv.message ?? ''}';

      emit(state.copyWith(
        listOnTheAirTv: resOnTheAirTv.results,
        listPopularTv: resPopularTv.results,
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
