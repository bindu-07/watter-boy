
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

class OtpController extends GetxController {

  static OtpController get instance => Get.find();

  final otp = TextEditingController();

  GlobalKey<FormState> verifyKey = GlobalKey<FormState>();

  void verifyOtpWithPhoneNumber(String? verificationId, String? phoneNumber, String? countryCode) async {
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('we are processing your application', WatterImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();

      ///  Internet Connection Check
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (otp.text.trim().isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Required', message: 'OTP is required');
        return;
      }
      /// Form validation
      if(verifyKey.currentState == null || !verifyKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final otpCode = otp.text.trim();
     //Register User in the Firebase Authentication & save user data in firebase
      final userCredential = await AuthenticationRepository.instance.verifyOtpAndLogin(verificationId: verificationId ?? '', smsCode: otpCode);

      String deviceType = "";
      if(WatterDeviceUtils.isAndroid()) {
        deviceType = "Android" ;
      } else {
        deviceType = "IOS";
      }
      /// save user data in Firebase FireStore
      final user = UserModel(
          id: userCredential.user!.uid,
          name: "",
          email: "",
          phoneNumber: phoneNumber?? '',
          profilePicture: "",
          userType: 0, countryCode: countryCode??'', deviceToken: "", deviceType: deviceType, latitude: "", longitude: ""
      );

      final userRepo = Get.put(UserRepository());
      await userRepo.saveUserData(user);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Congratulation', message: 'Your account is created.');
      Get.to(()=>  const NavigationMenu());
      /*TLoaders.successSnackBar(title: 'OTP Sent', message: 'Check your phone for the OTP.');*/
    } catch (e) {
      print('❌ Exception: $e');
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }

  }
}
