import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomText(text: 'Test'),
      ),
    );
  }
}
