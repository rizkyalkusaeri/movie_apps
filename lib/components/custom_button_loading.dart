import 'package:movie_apps/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonLoading extends StatelessWidget {
  const CustomButtonLoading({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.title,
    this.titleColor = Colors.white,
    this.titleFontWeight = FontWeight.w600,
    this.height = 20,
    this.width = double.infinity,
    this.borderColor = Colors.transparent,
    this.onPressed,
  }) : super(key: key);
  final Color backgroundColor;
  final Color foregroundColor;
  final Color titleColor;
  final Widget title;
  final double height;
  final double width;
  final FontWeight titleFontWeight;
  final Color borderColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              foregroundColor,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: borderColor),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor,
            ),
            minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.primary.withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return AppColors.primary.withOpacity(0.12);
                }
                return null; // Defer to the widget's default.
              },
            ),
          ),
          child: title),
    );
  }
}
