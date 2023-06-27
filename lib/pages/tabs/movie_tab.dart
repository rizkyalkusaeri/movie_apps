import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/pages/detail_page.dart';
import 'package:movie_apps/utils/animation.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';

class MovieTab extends StatefulWidget {
  const MovieTab({Key? key}) : super(key: key);

  @override
  State<MovieTab> createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  final TextEditingController _searchController = TextEditingController();
  late final PageController _pageController;

  final List<String> _coverOfImage = [
    'https://i.ytimg.com/vi/0n7llXgSn4U/maxresdefault.jpg',
    'https://assets-global.website-files.com/6009ec8cda7f305645c9d91b/6408f6e7b5811271dc883aa8_batman-min.png',
    'https://i.ebayimg.com/images/g/ujkAAOSwYEhjyt9a/s-l1600.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/movie-poster-template-design-21a1c803fe4ff4b858de24f5c91ec57f_screen.jpg',
    'https://images.moviesanywhere.com/6305a9e8ed76d5fa485ac16637655cf7/bcc68be4-eede-409b-a63d-e179b28d19b4.jpg',
  ];

  final List<String> images = [
    'https://i.ebayimg.com/images/g/ujkAAOSwYEhjyt9a/s-l1600.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/movie-poster-template-design-21a1c803fe4ff4b858de24f5c91ec57f_screen.jpg',
    'https://images.moviesanywhere.com/6305a9e8ed76d5fa485ac16637655cf7/bcc68be4-eede-409b-a63d-e179b28d19b4.jpg',
  ];

  int activePage = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: images.length,
                  pageSnapping: true,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    //checking active position
                    bool active = pagePosition == activePage;
                    return slider(images, pagePosition, active);
                  },
                ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: SizeConfig.screenWidth! / 2.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, activePage),
                ),
              ),
            ],
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
                _trendingMoviesWidget(),
                _recommendedMoviesWidget(),
                _popularMoviesWidget(),
              ],
            ),
          ),
        ],
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

  AnimatedContainer slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            images[pagePosition],
          ),
        ),
      ),
    );
  }

  Container _trendingMoviesWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _titleOfListWidget('Trending Movies'),
          _listOfMoviesWidget()
        ],
      ),
    );
  }

  Container _recommendedMoviesWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [_titleOfListWidget('Recommended'), _listOfMoviesWidget()],
      ),
    );
  }

  Container _popularMoviesWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _titleOfListWidget('Popular In Cinemas'),
          _listOfMoviesWidget()
        ],
      ),
    );
  }

  Container _listOfMoviesWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 180,
      child: ListView.separated(
        itemCount: _coverOfImage.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, createRoute(const DetailPage()));
            },
            child: Container(
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    _coverOfImage[index],
                  ),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                ),
              ),
            ),
          );
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

  Row _titleOfListWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: 'See all',
          color: AppColors.secondary,
          fontWeight: FontWeight.w400,
        )
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
