import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/utils/app_colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _headWidget(),
          _itemMenu(
            Icon(
              CupertinoIcons.heart,
              color: AppColors.white,
            ),
            'Liked',
          ),
          _itemMenu(
            Icon(
              CupertinoIcons.bookmark,
              color: AppColors.white,
            ),
            'Saved',
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 30, top: 10, bottom: 10),
            child: Container(
              color: AppColors.gray,
              height: 1,
              width: double.infinity,
            ),
          ),
          _itemMenu(
            Icon(
              CupertinoIcons.globe,
              color: AppColors.white,
            ),
            'Languages',
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 30, top: 10, bottom: 10),
            child: Container(
              color: AppColors.gray,
              height: 1,
              width: double.infinity,
            ),
          ),
          _itemMenu(
            Icon(
              CupertinoIcons.trash,
              color: AppColors.white,
            ),
            'Clear Cache',
          ),
          _itemMenu(
            Icon(
              CupertinoIcons.time,
              color: AppColors.white,
            ),
            'Clear History',
          ),
          _itemMenu(
            const Icon(
              CupertinoIcons.arrow_left_square,
              color: Colors.red,
            ),
            'Log Out',
          ),
          // FittedBox(
          //   child: Container(
          //     margin: const EdgeInsets.only(top: 36),
          //     decoration: BoxDecoration(
          //       color: Colors.red.shade600,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             CupertinoIcons.arrow_left_square,
          //             color: AppColors.white,
          //           ),
          //           const SizedBox(
          //             width: 8,
          //           ),
          //           CustomText(
          //             text: 'Log Out',
          //             fontWeight: FontWeight.w500,
          //             color: AppColors.white,
          //             fontSize: 14,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  ListTile _itemMenu(Icon icons, String title) {
    return ListTile(
      leading: icons,
      title: CustomText(
        text: title,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      dense: true,
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          CupertinoIcons.right_chevron,
          color: AppColors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _headWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 20),
      child: Row(
        children: [
          _avatarWidget(),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomText(
                text: 'Rizky Al Kusaeri',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              CustomText(
                text: 'Indonesia',
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _avatarWidget() {
    return Container(
      width: 120,
      height: 120,
      margin: const EdgeInsets.only(bottom: 8),
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
