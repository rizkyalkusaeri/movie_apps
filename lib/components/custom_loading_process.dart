import 'package:flutter/cupertino.dart';
import 'package:movie_apps/utils/app_colors.dart';

class CustomLoadingProcess extends StatelessWidget {
  const CustomLoadingProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoActivityIndicator(
                color: AppColors.secondary,
              ),
              FittedBox(
                child: Text(
                  'Sedang Memproses Data',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
