
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:water_boy/features/authentication/screens/login/enter_otp.dart';
import 'package:water_boy/navigation_menu.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/helper/network_manager.dart';
import 'package:water_boy/utils/popups/full_screen_loader.dart';
import 'package:water_boy/utils/popups/loaders.dart';

import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../../../utils/device/device_utility.dart';
import '../../models/users/user_mode.dart';

class LoginController extends GetxController {

  static LoginController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final countryCode = TextEditingController();

  GlobalKey<FormState> numberKey = GlobalKey<FormState>();

  void sendOtpInPhoneNumber() async {
    try{
      // start loading
      final isConnected = await NetworkManager.instance.isConnected();

      ///  Internet Connection Check
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (phoneNumber.text.trim().isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Required', message: 'Phone number is required');
        return;
      }
      /// Form validation
      if(numberKey.currentState == null || !numberKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final fullNumber = phoneNumber.text.trim();
      await AuthenticationRepository.instance.sendOtpToPhoneNumber(fullNumber,countryCode.text.trim());

      /*TLoaders.successSnackBar(title: 'OTP Sent', message: 'Check your phone for the OTP.');*/
    } catch (e) {
      print('❌ Exception: $e');
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }

  }

  /// Google login
  void continueWithGoogle() async {
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('we are processing your application', WatterImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();

      ///  Internet Connection Check
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      //Register User in the Firebase Authentication & save user data in firebase
      final userCredential = await AuthenticationRepository.instance.singInWithGoogle();

      String deviceType = "";
      if(WatterDeviceUtils.isAndroid()) {
        deviceType = "Android" ;
      } else {
        deviceType = "IOS";
      }
      final token = await FirebaseMessaging.instance.getToken();
      /// save user data in Firebase FireStore
      final userRepo = Get.put(UserRepository());
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        /// Only create the user if not already exists
        final user = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
            userType: 0,
            countryCode: "",
            deviceToken: token!,
            deviceType: deviceType
        );

        await userRepo.saveUserData(user);
      } else {
        /// If already exists, just update deviceToken and deviceType if needed
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).update({
          'deviceToken': token,
          'deviceType': deviceType,
        });
      }

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Congratulation', message: 'Your account is created.');
      Get.to(()=>  const NavigationMenu());

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }

  }
}
