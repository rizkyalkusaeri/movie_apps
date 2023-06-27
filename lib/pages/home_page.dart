import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_bottom_bar.dart';
import 'package:movie_apps/pages/tabs/movie_tab.dart';
import 'package:movie_apps/pages/tabs/profile_tab.dart';
import 'package:movie_apps/pages/tabs/tv_tab.dart';
import 'package:movie_apps/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inactiveColor = Colors.grey;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getBody(),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const MovieTab(),
      const TvTab(),
      const ProfileTab(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.black,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(CupertinoIcons.film),
          title: const Text('Movies'),
          activeColor: AppColors.secondary,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(CupertinoIcons.tv),
          title: const Text('Televisions'),
          activeColor: AppColors.secondary,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: const Text(
            'Profile',
          ),
          activeColor: AppColors.secondary,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
