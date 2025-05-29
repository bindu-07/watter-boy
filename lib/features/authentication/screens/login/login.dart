import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:water_boy/common/styles/spacing_styles.dart';
import 'package:water_boy/features/authentication/controllers/login/login_controller.dart';
import 'package:water_boy/features/authentication/screens/login/enter_email.dart';
import 'package:water_boy/features/authentication/screens/login/enter_otp.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/constants/text_string.dart';

import '../../../../utils/helper/helper_function.dart';
import '../../../../utils/validators/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    final controller = Get.put(LoginController());
    return Scaffold(
        body: Form(
          key: controller.numberKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: WatterSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                //// logo title subtitle
                children: [
                  Column(
                    children: [
                      Image(image: AssetImage(dark? WatterImages.transparentLogo: WatterImages.transparentLogo),width: 160, height: 160,),
                      /*Text(WatterText.welcome, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: WatterSizes.sm,),*/
                      Text(WatterText.loginsubtitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
                      const SizedBox(height: WatterSizes.spaceBtwItems * 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Divider(
                            color: dark?WatterColors.darkGrey: WatterColors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5,
                          ),
                          ),
                          Text(WatterText.orSignInWith, style: Theme.of(context).textTheme.bodyLarge,),
                          Flexible(child: Divider(
                            color: dark?WatterColors.darkGrey: WatterColors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 60,
                          ),
                          )

                        ],
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: WatterSizes.spaceBtwSections),
                    child: Column(
                      children: [
                        /*TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: WatterText.email
                      ),
                    ),*/
                        IntlPhoneField(
                          initialCountryCode: "IN",
                          validator: (value) {
                            return WatterValidator.validatePhoneNumber(value?.completeNumber?? '');},
                          onChanged: (phone) {
                            controller.phoneNumber.text = phone.completeNumber;  // Stores full number like "+91xxxxxxxxxx"
                          },
                          decoration: InputDecoration(
                              labelText: WatterText.enterNumber,
                              floatingLabelStyle: TextStyle(
                                color: dark ? Colors.white : Colors.black, // when it floats
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide()
                              )
                          ),

                        ),
                        const SizedBox(height: WatterSizes.spaceBtwInputFields,),

                        //// SigIn Button

                        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.sendOtpInPhoneNumber(), child: const Text(WatterText.signIn))),

                      ],

                    ),
                    //// Deviders

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Divider(
                        color: dark?WatterColors.darkGrey: WatterColors.grey,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      ),
                      ),
                      Text("or", style: Theme.of(context).textTheme.bodyLarge,),
                      Flexible(child: Divider(
                        color: dark?WatterColors.darkGrey: WatterColors.grey,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      ),
                      )

                    ],
                  ),
                  const SizedBox(height: WatterSizes.spaceBtwSections,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(decoration: BoxDecoration(border: Border.all(color: WatterColors.grey), borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                            onPressed: ()=> controller.continueWithGoogle(),
                            icon: const Image(image: AssetImage(WatterImages.google), width: WatterSizes.iconMd, height: WatterSizes.iconMd,),
                          ),
                        ),
                        const SizedBox(width: WatterSizes.spaceBtwItems,),
                        Container(decoration: BoxDecoration(border: Border.all(color: WatterColors.grey), borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                            onPressed: ()=> Get.to(const EnterEmailScreen()),
                            icon: Image(image: const AssetImage(WatterImages.email), width: WatterSizes.iconMd, height: WatterSizes.iconMd, color: dark? Colors.white: Colors.black,),
                          ),
                        ),
                      ]
                  ),

                ],
              ),
            ),
          ),
        ),


    );
  }
}
