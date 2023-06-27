import 'package:equatable/equatable.dart';

class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovies extends MovieEvent {
  final String type;

  GetMovies(this.type);

  @override
  List<Object?> get props => [type];
}
