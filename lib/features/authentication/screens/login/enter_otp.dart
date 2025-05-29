import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:water_boy/features/authentication/controllers/login/otp_controller.dart';
import 'package:water_boy/navigation_menu.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';
import '../../../../utils/helper/helper_function.dart';


class EnterOtpScreen extends StatelessWidget {
  const EnterOtpScreen({super.key, this.phoneNumber, this.verificationId});
  final String? phoneNumber;
  final String? verificationId;

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final dark = WatterHelperFunction.isDarkMode(context);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    final controller = Get.put(OtpController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          WatterText.otpVerify,
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
      body: Form(
        key: controller.verifyKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: WatterSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              //// logo title subtitle
              children: [
                Column(
                  children: [
                    /*Text(WatterText.welcome, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: WatterSizes.sm,),*/
                    Text(WatterText.sentCode, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                    Text(phoneNumber?? ' ', style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
                    const SizedBox(height: WatterSizes.spaceBtwItems * 2,),
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
                      Pinput(
                        // You can pass your own SmsRetriever implementation based on any package
                        // in this example we are using the SmartAuth
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the OTP';
                          } else if (value.length != 6) {
                            return 'OTP must be 6 digits';
                          }
                          return null; // valid
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          controller.otp.text = pin;
                          print('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          controller.otp.text = value;
                          print('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                      const SizedBox(height: WatterSizes.spaceBtwInputFields * 2,),

                      //// SigIn Button

                      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.verifyOtpWithPhoneNumber(verificationId, phoneNumber), child: const Text(WatterText.signIn))),

                    ],
                  ),
                  //// Deviders
                ),
                TextButton(onPressed: ()=> Get.back(), child: const Text(WatterText.gologin),)


              ],
            ),
          ),
        ),
      )
    );
  }
}
