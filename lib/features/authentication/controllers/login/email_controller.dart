
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:meta/meta.dart';
import 'package:water_boy/data/repository/authentication/authentication_repository.dart';
import 'package:water_boy/data/repository/user/user_repository.dart';
import 'package:water_boy/features/authentication/models/users/user_mode.dart';
import 'package:water_boy/features/authentication/screens/login/verify_email.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/device/device_utility.dart';
import 'package:water_boy/utils/helper/network_manager.dart';
import 'package:water_boy/utils/popups/full_screen_loader.dart';
import 'package:water_boy/utils/popups/loaders.dart';

class EmailController extends GetxController {

  static EmailController get instance => Get.find();

  final email = TextEditingController();

  GlobalKey<FormState> emailKey = GlobalKey<FormState>();

  void continueWithEmail() async {
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('we are processing your application', WatterImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();

      ///  Internet Connection Check
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form validation
      if(!emailKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
         return;
      }

      //Register User in the Firebase Authentication & save user data in firebase
      final userCredential = await AuthenticationRepository.instance.registerOrLoginWithEmail(email.text.trArgs(), "123456");

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
           email: email.text.trim(),
           phoneNumber: "",
           profilePicture: "", userType: 0, countryCode: "", deviceToken: "", deviceType: deviceType
       );

       final userRepo = Get.put(UserRepository());
       await userRepo.saveUserData(user);

       TFullScreenLoader.stopLoading();

       TLoaders.successSnackBar(title: 'Congratulation', message: 'Your account is created verify email to continue');
       Get.to(()=>  VerifyEmailScreen(email: email.text.trim(),));
       
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }

}
}
