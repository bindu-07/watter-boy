import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:water_boy/common/widgets/success_screen.dart';
import 'package:water_boy/data/repository/authentication/authentication_repository.dart';
import 'package:water_boy/navigation_menu.dart';
import 'package:water_boy/utils/popups/loaders.dart';


class VerifyEmailController extends GetxController {

  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

   sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await AuthenticationRepository.instance.sendEmailVerification();
      if(user!=null && !user.emailVerified) {
        TLoaders.successSnackBar(title:  'Email send', message: 'Please check your inbox and verify your email.');
      }
    } catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
   }

   setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified?? false) {
        timer.cancel();
        Get.off(()=> NavigationMenu());
      }
    });
   }

   checkEmailVerificationStatus() {
     final user = FirebaseAuth.instance.currentUser;
     if(user!=null && user.emailVerified) {
       Get.off(()=> NavigationMenu());
     }
   }

}
