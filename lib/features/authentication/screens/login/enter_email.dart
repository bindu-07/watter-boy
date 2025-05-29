import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/features/authentication/controllers/login/email_controller.dart';
import 'package:water_boy/features/authentication/screens/login/verify_email.dart';
import 'package:water_boy/utils/validators/validation.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../../utils/helper/helper_function.dart';

class EnterEmailScreen extends StatelessWidget {
  const EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    final controller = Get.put(EmailController());
    return Form(
      key: controller.emailKey,
      child: Scaffold(appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          WatterText.continueEmail,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: (){Get.back();},
          icon:  Icon(Icons.arrow_back_ios_rounded,color: dark? Colors.white: Colors.black,),
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: WatterSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              //// logo title subtitle
              children: [
                Column(
                  children: [
                    /*Text(WatterText.welcome, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: WatterSizes.sm,),*/
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        WatterText.email,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: WatterSizes.spaceBtwItems ,),

                    TextFormField(
                      validator: (value) => WatterValidator.validateEmail(value),
                      controller: controller.email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct),
                        labelText: WatterText.enterEmail,
                      ),
                    ),
                    const SizedBox(height: WatterSizes.spaceBtwItems * 2),
                    SizedBox(width: double.infinity, child: ElevatedButton(
                        onPressed: ()=> controller.continueWithEmail()/*Get.to(const VerifyEmailScreen())*/,
                        child: const Text(WatterText.signIn)
                    )
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),),
    );
  }
}
