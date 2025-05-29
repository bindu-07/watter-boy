import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../navigation_menu.dart';
import '../../utils/constants/image_string.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_string.dart';
import '../../utils/helper/helper_function.dart';
import '../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTittle,
      required this.onPressed});

  final String image, title, subTittle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: WatterSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            //// logo title subtitle
            children: [
              Image(
                image: AssetImage(image),
                width: WatterHelperFunction.screenWidth() * 0.5,
              ),
              const SizedBox(height: WatterSizes.spaceBtwSections),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: WatterSizes.spaceBtwItems),
              Text(
                subTittle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: WatterSizes.spaceBtwSections),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed,
                      child: const Text(WatterText.signIn))),
            ],
          ),
        ),
      ),
    );
  }
}
