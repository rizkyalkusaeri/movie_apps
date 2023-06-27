import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final String message;
  final StateStatus status;
  final List<Movie> listData;

  const MovieState({
    this.message = '',
    this.status = StateStatus.initial,
    List<Movie>? listData,
  }) : listData = listData ?? const [];

  @override
  List<Object?> get props => [message, status, listData];

  MovieState copyWith({
    String? message,
    StateStatus? status,
    List<Movie>? listData,
  }) {
    return MovieState(
      status: status ?? this.status,
      message: message ?? this.message,
      listData: listData ?? this.listData,
    );
  }
}
