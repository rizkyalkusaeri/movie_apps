import 'package:movie_apps/components/custom_button_loading.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomEmptyList extends StatelessWidget {
  const CustomEmptyList({Key? key, this.onTap, required this.title})
      : super(key: key);
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: SizeConfig.screenWidth! / 4,
              child: CustomButtonLoading(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primary,
                title: const Text('refresh'),
                borderColor: AppColors.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
