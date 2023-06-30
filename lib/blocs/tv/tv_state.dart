import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:equatable/equatable.dart';

class TvState extends Equatable {
  final String message;
  final StateStatus status;
  final List<Movie> listOnTheAirTv;
  final List<Movie> listPopularTv;

  const TvState({
    this.message = '',
    this.status = StateStatus.initial,
    List<Movie>? listOnTheAirTv,
    List<Movie>? listPopularTv,
  })  : listOnTheAirTv = listOnTheAirTv ?? const [],
        listPopularTv = listPopularTv ?? const [];

  @override
  List<Object?> get props => [
        message,
        status,
        listOnTheAirTv,
        listPopularTv,
      ];

  TvState copyWith({
    String? message,
    StateStatus? status,
    List<Movie>? listOnTheAirTv,
    List<Movie>? listPopularTv,
  }) {
    return TvState(
      status: status ?? this.status,
      message: message ?? this.message,
      listOnTheAirTv: listOnTheAirTv ?? this.listOnTheAirTv,
      listPopularTv: listPopularTv ?? this.listPopularTv,
    );
  }
}
