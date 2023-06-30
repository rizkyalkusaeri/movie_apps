import 'dart:async';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/blocs/detail/detail_bloc.dart';
import 'package:movie_apps/blocs/detail/detail_event.dart';
import 'package:movie_apps/blocs/tv/tv_bloc.dart';
import 'package:movie_apps/blocs/tv/tv_event.dart';
import 'package:movie_apps/blocs/tv/tv_state.dart';
import 'package:movie_apps/components/custom_error.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:movie_apps/data/app_services.dart';
import 'package:movie_apps/models/movie_model.dart';
import 'package:movie_apps/utils/state_status.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/pages/detail_page.dart';
import 'package:movie_apps/utils/animation.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class TvTab extends StatefulWidget {
  const TvTab({Key? key}) : super(key: key);

  @override
  State<TvTab> createState() => _TvTabState();
}

class _TvTabState extends State<TvTab> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  late Timer _timer;
  int _activePage = 0;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      // print('GO');

      if (_pageController.hasClients) {
        if (_activePage < 4) {
          _activePage++;
          _pageController.animateToPage(
            _activePage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        } else {
          _activePage = 0;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<TvBloc>();

    SizeConfig().init(context);

    return BlocListener<TvBloc, TvState>(
      listener: (context, state) {
        if ((state.status.isError || state.status.isDestroyError) &&
            state.message.isNotEmpty) {
          ElegantNotification.error(
            title: const Text('Gagal'),
            description: Text(state.message),
          ).show(context);
        }
      },
      child: BlocBuilder<TvBloc, TvState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () {
              final refresh = bloc..add(GetTelevisions());

              return refresh.stream.first;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: state.status.isError
                  ? const CustomError()
                  : _widgetLoad(state),
            ),
          );
        },
      ),
    );
  }

  Column _widgetLoad(TvState state) {
    return Column(
      children: [
        _carouselWidget(state),
        const SizedBox(
          height: 8,
        ),
        state.status.isInitial
            ? Shimmer.fromColors(
                baseColor: const Color(0xff212021),
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Container(
                  height: 10,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(
                    state.listOnTheAirTv.length < 6
                        ? state.listOnTheAirTv.length
                        : 6,
                    _activePage),
              ),
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
              _popularTvWidget(state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _carouselWidget(TvState state) {
    return state.status.isInitial ? _carouselUnload() : _carouselLoad(state);
  }

  Shimmer _carouselUnload() {
    return Shimmer.fromColors(
      baseColor: const Color(0xff212021),
      highlightColor: Colors.black.withOpacity(0.8),
      enabled: true,
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gray,
        ),
      ),
    );
  }

  SizedBox _carouselLoad(TvState state) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PageView.builder(
        itemCount:
            state.listOnTheAirTv.length < 6 ? state.listOnTheAirTv.length : 6,
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _activePage = page;
          });
        },
        itemBuilder: (context, pagePosition) {
          //checking active position
          bool active = pagePosition == _activePage;
          return slider(state.listOnTheAirTv, pagePosition, active);
        },
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? AppColors.secondary
              : const Color(0xff212021),
          shape: BoxShape.circle,
        ),
      );
    });
  }

  Widget slider(List<Movie> tvs, pagePosition, active) {
    var tv = tvs[pagePosition];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          createRoute(
            BlocProvider<DetailBloc>(
              create: (context) => DetailBloc(
                repository: context.read<AppRepository>(),
              )..add(GetDetailMovie(id: tv.id, type: 'tv')),
              child: DetailPage(
                id: tv.id,
                type: 'tv',
              ),
            ),
          ),
        );
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  tv.backdropPath.isNotEmpty
                      ? ASSET_URL + tv.backdropPath
                      : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.3),
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
                  Row(
                    children: [
                      const CustomText(text: 'TV On The Air'),
                      const SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 2, left: 4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      )
                    ],
                  ),
                  CustomText(
                    text: tv.title,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            left: -20,
            child: Image.asset(
              'assets/icons/logo.png',
              width: 150,
            ),
          )
        ],
      ),
    );
  }

  Container _popularTvWidget(TvState state) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _titleOfListWidget('Popular Now'),
          _listOfTvWidget(state: state, listTv: state.listPopularTv)
        ],
      ),
    );
  }

  Widget _listOfTvWidget(
      {required TvState state, required List<Movie> listTv}) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 20,
        ),
        itemCount: listTv.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return state.status.isInitial
              ? _listOfTvUnload()
              : _listOfTvLoad(context, index, listTv);
        },
      ),
    );
  }

  GestureDetector _listOfTvLoad(
      BuildContext context, int index, List<Movie> listTv) {
    var tv = listTv[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          createRoute(
            BlocProvider<DetailBloc>(
              create: (context) => DetailBloc(
                repository: context.read<AppRepository>(),
              )..add(GetDetailMovie(id: tv.id, type: 'tv')),
              child: DetailPage(
                id: tv.id,
                type: 'tv',
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
                  tv.posterPath.isNotEmpty
                      ? ASSET_URL + tv.posterPath
                      : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
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
            bottom: 4,
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
                    text: tv.title,
                    textAlign: TextAlign.left,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: tv.voteAverage,
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

  Shimmer _listOfTvUnload() {
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

  Row _titleOfListWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  // TextFormField _searchBarWidget() {
  //   return TextFormField(
  //     controller: _searchController,
  //     cursorColor: AppColors.white,
  //     style: GoogleFonts.poppins(
  //       color: AppColors.white,
  //       fontSize: 12,
  //     ),
  //     decoration: InputDecoration(
  //       hintText: 'Search for movies',
  //       hintStyle: GoogleFonts.poppins(
  //         color: AppColors.inputField,
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       filled: true,
  //       isDense: true,
  //       fillColor: const Color(0xff212021),
  //       suffixIcon: Icon(
  //         CupertinoIcons.search,
  //         color: AppColors.white,
  //       ),
  //     ),
  //   );
  // }
}
