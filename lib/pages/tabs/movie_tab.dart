import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/blocs/movie/movie_bloc.dart';
import 'package:movie_apps/blocs/movie/movie_event.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:movie_apps/pages/tabs/views/movie_view.dart';

class MovieTab extends StatelessWidget {
  const MovieTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        repository: context.read<AppRepository>(),
      )..add(GetMovies('now')),
      child: const MovieView(),
    );
  }
}
