import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/text_string.dart';
import 'package:water_boy/utils/device/device_utility.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import '../../controllers/onbording/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(OnboardingController());
    return  Scaffold(
      body: Stack(
        children: [
          //// Horizontal Scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(image: WatterImages.onboarding_image1, title: WatterText.onboardingTitle1, subTitle: WatterText.onboardingsubTitle1,),
              OnBoardingPage(image: WatterImages.onboarding_image2, title: WatterText.onboardingTitle2, subTitle: WatterText.onboardingsubTitle2,),
              OnBoardingPage(image: WatterImages.onboarding_image3, title: WatterText.onboardingTitle3, subTitle: WatterText.onboardingsubTitle3,),
            ],
          ),

          //// Skip Button
           const OnBoardingSkip(),

          //// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          ////Circular Next Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);

    return Positioned(right: 24.0, bottom: WatterDeviceUtils.getBottomNavigationBarHeight()
        ,child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark? WatterColors.primary: Colors.black),
          onPressed: ()=> OnboardingController.instance.nextPage(),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = WatterHelperFunction.isDarkMode(context);

    return Positioned(bottom: WatterDeviceUtils.getBottomNavigationBarHeight()+25, left: 24.0, child: SmoothPageIndicator(
        controller: controller.pageController,
      onDotClicked: controller.dotNavigationClicked,
      count: 3,
      effect: ExpandingDotsEffect(
          activeDotColor: dark ? Colors.white: Colors.black ,
          dotHeight: 6)
      ,)
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: WatterDeviceUtils.getAppBarHeight(), right:24.0,child: TextButton(onPressed: ()=> OnboardingController.instance.skipPage(), child: const Text("Skip"),));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });

  final String image, title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image(
              width: WatterHelperFunction.screenWidth() * 0.6,
              height: WatterHelperFunction.screenHeight() * 0.6,
              image:  AssetImage(image)
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}