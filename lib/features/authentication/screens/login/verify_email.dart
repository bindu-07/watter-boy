import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/data/repository/authentication/authentication_repository.dart';
import 'package:water_boy/features/authentication/controllers/login/verify_email_controller.dart';
import 'package:water_boy/features/authentication/screens/login/login.dart';
import 'package:water_boy/utils/constants/image_string.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/success_screen.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../../utils/helper/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;
  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: WatterSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            //// logo title subtitle
            children: [
             Image(image: const AssetImage(WatterImages.deliveredEmailIllustration), width: WatterHelperFunction.screenWidth() * 0.5,),

              const SizedBox(height: WatterSizes.spaceBtwSections),
              Text(
                WatterText.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: WatterSizes.spaceBtwItems ),
              Text(
                email ?? ' ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: WatterSizes.spaceBtwItems ),
              Text(
                WatterText.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: WatterSizes.spaceBtwSections ),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.checkEmailVerificationStatus(), child: const Text(WatterText.signIn))),
              const SizedBox(height: WatterSizes.spaceBtwItems ),
              SizedBox(width: double.infinity, child: TextButton(onPressed: ()=> controller.sendEmailVerification(), child: const Text(WatterText.resendEmail))),

            ],
          ),
        ),
      ),
    );
  }
}
