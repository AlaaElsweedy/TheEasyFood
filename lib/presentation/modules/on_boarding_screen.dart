import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../helpers/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';
import '../layouts/intro_layout.dart';

class OnBoardingScreen extends StatelessWidget {
  final List<String> images = const [
    'assets/images/on_boarding_3.png',
    'assets/images/on_boarding_2.png',
    'assets/images/on_boarding_1.png',
  ];

  final List<String> titles = const [
    'Find Food You Love',
    'Fast Delivery',
    'Live Tracking',
  ];
  final List<String> descriptions = const [
    'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
    'Fast food delivery to your home, office wherever you are',
    'Real time tracking of your food on the app once you placed the order',
  ];

  final PageController controller = PageController();

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      images[index],
                      height: 300,
                    ),
                    sizedBox28,
                    BuildHeader(title: titles[index]),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BuildSecondHeader(
                        title: descriptions[index],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: images.length,
              ),
            ),
            SmoothPageIndicator(
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: mainColor,
                dotHeight: 10,
                expansionFactor: 2,
                dotWidth: 10,
                spacing: 5.0,
              ),
              controller: controller,
              count: images.length,
            ),
            sizedBox28,
            DefaultButton(
              title: 'next'.toUpperCase(),
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value: true)
                    .then((value) {
                  navigateAndFinish(context, const IntroLayout());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
