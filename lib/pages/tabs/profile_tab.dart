import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/utils/app_colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headWidget(),
      ],
    );
  }

  Widget _headWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: _avatarWidget(),
        title: const CustomText(
          text: 'Halo, Rizky',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        subtitle: const CustomText(
          text: 'Cari movie terbaru disini!',
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.bell_fill,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Container _avatarWidget() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/avatar.jpg',
          ),
        ),
      ),
    );
  }
}
