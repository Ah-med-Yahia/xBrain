import 'package:explaino/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView1 extends StatelessWidget {
  const OnBoardingPageView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.images.onBoarding1.path, width: double.infinity),
      ],
    );
  }
}
