import 'package:equatable/equatable.dart';

class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailMovie extends DetailEvent {
  final int id;
  final String type;

  GetDetailMovie({required this.id, required this.type});

  @override
  List<Object?> get props => [id, type];
}
