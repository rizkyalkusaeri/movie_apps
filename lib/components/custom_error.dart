import 'package:flutter/cupertino.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';

class CustomError extends StatelessWidget {
  const CustomError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight! / 1.2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: 'Something went wrong, please refresh again',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            Icon(
              CupertinoIcons.chevron_compact_down,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
