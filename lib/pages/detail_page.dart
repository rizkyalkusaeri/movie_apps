import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/blocs/detail/detail_bloc.dart';
import 'package:movie_apps/blocs/detail/detail_event.dart';
import 'package:movie_apps/blocs/detail/detail_state.dart';
import 'package:movie_apps/components/custom_error.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/data/app_services.dart';
import 'package:movie_apps/models/cast_model.dart';
import 'package:movie_apps/models/detail_movie_model.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.id,
    required this.type,
  }) : super(key: key);
  final int id;
  final String type;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var bloc = context.read<DetailBloc>();
    return BlocListener<DetailBloc, DetailState>(
      listener: (context, state) {
        if ((state.status.isError || state.status.isDestroyError) &&
            state.message.isNotEmpty) {
          ElegantNotification.error(
            title: const Text('Gagal'),
            description: Text(state.message),
          ).show(context);
        }
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () {
                  final refresh = bloc..add(GetDetailMovie(id: id, type: type));

                  return refresh.stream.first;
                },
                child: state.status.isInitial
                    ? Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.secondary,
                        ),
                      )
                    : (state.status.isError || state.detailMovie == null)
                        ? const CustomError()
                        : _successLoad(state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listOfCastWidget({
    required DetailState state,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 180,
      child: ListView.separated(
        itemCount: state.listCast.length < 7 ? state.listCast.length : 7,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return state.status.isInitial
              ? _listOfCastUnload()
              : _listOfCastLoad(context, index, state.listCast);
        },
        separatorBuilder: (
          BuildContext context,
          int index,
        ) {
          return const SizedBox(
            width: 12,
          );
        },
      ),
    );
  }

  Widget _listOfCastLoad(
      BuildContext context, int index, List<CastModel> listCast) {
    var cast = listCast[index];
    return Stack(
      children: [
        Container(
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(
                cast.profilePath.isNotEmpty
                    ? ASSET_URL + cast.profilePath
                    : 'https://www.seekpng.com/png/detail/202-2024994_profile-icon-profile-logo-no-background.png',
              ),
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 130,
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
                  textAlign: TextAlign.left,
                  text: cast.name,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: 'as ${cast.character}',
                  fontSize: 12,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Shimmer _listOfCastUnload() {
    return Shimmer.fromColors(
      baseColor: const Color(0xff212021),
      highlightColor: Colors.black.withOpacity(0.8),
      enabled: true,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  NestedScrollView _successLoad(DetailState state) {
    var movie = state.detailMovie!;
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: SizeConfig.screenHeight! / 2.2,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.white),
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: _coverWidget(movie),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: genreWidget(movie),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Released on',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    CustomText(
                      text: movie.releaseDate,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              // _listOfInformationWidget(movie),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Synopsis',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    CustomText(
                      text: movie.overview.isEmpty
                          ? 'No overview yet'
                          : movie.overview,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              const CustomText(
                text: 'Popular Cast',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              _listOfCastWidget(state: state),
            ],
          ),
        ),
      ),
    );
  }

  FlexibleSpaceBar _coverWidget(DetailMovie movie) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  movie.backdropPath.isNotEmpty
                      ? ASSET_URL + movie.backdropPath
                      : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
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
          Positioned(
            bottom: 20,
            width: SizeConfig.screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: movie.originalTitle,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: type == 'tv'
                            ? '${movie.numberOfEpisode} Episode | '
                            : '${movie.runtime} min | ',
                        fontSize: 12,
                      ),
                      CustomText(
                        text: movie.voteAverage,
                        fontSize: 12,
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

  Widget genreWidget(DetailMovie movie) {
    var genres = '';

    for (var i in movie.genres) {
      genres += (i.name);
      genres += ',';
    }

    genres = genres.substring(0, genres.length - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Genre ',
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        CustomText(text: genres),
      ],
    );
  }

  // Container _listOfInformationWidget(DetailMovie movie) {
  //   var genres = '';

  //   for (var i in movie.genres) {
  //     genres += (i.name);
  //     genres += ',';
  //   }

  //   genres = genres.substring(0, genres.length - 1);

  //   return Container(
  //     margin: const EdgeInsets.only(top: 12),
  //     height: 60,
  //     child: ListView(
  //       shrinkWrap: true,
  //       scrollDirection: Axis.horizontal,
  //       children: [
  //         _itemOfInformationWidget('Genre', CustomText(text: genres)),
  //         _itemOfInformationWidget(
  //             'Run Time', CustomText(text: '${movie.runtime} min')),
  //         _itemOfInformationWidget(
  //           'Rating',
  //           Row(
  //             children: [
  //               CustomText(
  //                 text: movie.voteAverage,
  //                 fontSize: 14,
  //               ),
  //               Icon(
  //                 Icons.star,
  //                 color: AppColors.secondary,
  //                 size: 16,
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Container _itemOfInformationWidget(String title, Widget subtitle) {
  //   return Container(
  //     margin: const EdgeInsets.only(right: 8),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(16),
  //       color: const Color(0xff212021),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           CustomText(
  //             text: title,
  //             fontWeight: FontWeight.w700,
  //           ),
  //           subtitle
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
