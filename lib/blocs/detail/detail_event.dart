import 'package:equatable/equatable.dart';

class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailMovie extends DetailEvent {
  final int id;

  GetDetailMovie({required this.id});

  @override
  List<Object?> get props => [id];
}
