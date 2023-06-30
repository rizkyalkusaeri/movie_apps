import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/blocs/detail/detail_bloc.dart';
import 'package:movie_apps/blocs/detail/detail_event.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:movie_apps/data/app_services.dart';
import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/pages/detail_page.dart';
import 'package:movie_apps/utils/animation.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';

class SeeAllMovie extends StatelessWidget {
  const SeeAllMovie({Key? key, required this.listMovie, required this.title})
      : super(key: key);

  final List<Movie> listMovie;
  final String title;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: _widgetLoad(),
      ),
    );
  }

  Column _widgetLoad() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _listOfTvWidget(listMovie: listMovie),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listOfTvWidget({required List<Movie> listMovie}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 20,
      ),
      itemCount: listMovie.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _listOfTvLoad(context, index, listMovie);
      },
    );
  }

  GestureDetector _listOfTvLoad(
      BuildContext context, int index, List<Movie> listMovie) {
    var movie = listMovie[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          createRoute(
            BlocProvider<DetailBloc>(
              create: (context) => DetailBloc(
                repository: context.read<AppRepository>(),
              )..add(GetDetailMovie(id: movie.id, type: 'movie')),
              child: DetailPage(
                id: movie.id,
                type: 'movie',
              ),
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(
                  movie.posterPath.isNotEmpty
                      ? ASSET_URL + movie.posterPath
                      : '',
                ),
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: SizeConfig.screenWidth,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            width: SizeConfig.screenWidth! / 2.8,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 4,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: movie.originalTitle,
                    textAlign: TextAlign.left,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: movie.voteAverage,
                        fontSize: 12,
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.secondary,
                        size: 16,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
