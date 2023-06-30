import 'package:movie_apps/models/cast_model.dart';
import 'package:movie_apps/models/detail_movie_model.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  final String message;
  final StateStatus status;
  final DetailMovie? detailMovie;
  final List<CastModel> listCast;

  const DetailState({
    this.message = '',
    this.status = StateStatus.initial,
    this.detailMovie,
    List<CastModel>? listCast,
  }) : listCast = listCast ?? const [];

  @override
  List<Object?> get props => [message, status, detailMovie, listCast];

  DetailState copyWith({
    String? message,
    StateStatus? status,
    DetailMovie? detailMovie,
    List<CastModel>? listCast,
  }) {
    return DetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      detailMovie: detailMovie ?? this.detailMovie,
      listCast: listCast ?? this.listCast,
    );
  }
}
