import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_text.dart';

class TvTab extends StatelessWidget {
  const TvTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(text: 'Television'),
    );
  }
}
