import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_boy/features/authentication/screens/login/login.dart';
import 'package:water_boy/features/authentication/screens/login/verify_email.dart';
import 'package:water_boy/features/authentication/screens/onboarding/onboarding.dart';
import 'package:water_boy/navigation_menu.dart';
import 'package:water_boy/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:water_boy/utils/exceptions/format_exceptions.dart';
import 'package:water_boy/utils/exceptions/platform_exceptions.dart';

import '../../../features/authentication/screens/login/enter_otp.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class AuthenticationRepository extends GetxController {
   static AuthenticationRepository get instance => Get.find();

   final deviceStorage = GetStorage();
   final _auth  = FirebaseAuth.instance;

   User? get authUser => _auth.currentUser;

   @override
   void onReady() {
     super.onReady();
     WidgetsBinding.instance.addPostFrameCallback((_) {
       screenReady(_auth.currentUser);
     });
   }


  screenReady(User? user) async {
     print('user details: $user');
     if(user!=null) {
       deviceStorage.writeIfNull('IsFirstTime', true);
       if(deviceStorage.read('IsFirstTime') != true ) {
         if (user.emailVerified || user.phoneNumber!.isNotEmpty) {
           Get.offAll(() => const NavigationMenu());
         } else {
           Get.offAll(() =>
               VerifyEmailScreen(email: _auth.currentUser?.email,));
         }
       } else {
         await FirebaseAuth.instance.signOut();
         print("➡️ Navigating to OnBoardingScreen");
         Get.offAll(() => const OnBoardingScreen());
       }
     } else {
       deviceStorage.writeIfNull('IsFirstTime', true);
       print(" screenReady  ${deviceStorage.read('IsFirstTime')}");
       if(deviceStorage.read('IsFirstTime') != true ){
         print("➡️ Navigating to LoginScreen");
         Get.offAll(()=> const LoginScreen());
       } else {
         print("➡️ Navigating to OnBoardingScreen");
         Get.offAll(() => const OnBoardingScreen());
       }
     }
  }

  // Register
   Future<UserCredential> registerOrLoginWithEmail(String email, String password) async{
     try {
       return await _auth.signInWithEmailAndPassword(email: email, password: password);
     } on FirebaseAuthException catch (e) {
       print(e.code);
       if (e.code == 'invalid-credential') {
         // If user not found, then register
         try {
           return await _auth.createUserWithEmailAndPassword(email: email, password: password);
         } on FirebaseAuthException catch (e) {
           throw TFirebaseAuthException(e.code).message;
         } on FirebaseException catch (e) {
           throw TFirebaseException(e.code).message;
         } on FormatException {
           throw const TFormatException().message;
         } on PlatformException catch (e) {
           throw TPlatformException(e.code).message;
         } catch (_) {
           throw 'Something went wrong during registration.';
         }
       } else if (e.code == 'wrong-password') {
         throw 'Wrong password. Please try again.';
       } else {
         throw TFirebaseAuthException(e.code).message;
       }
     } catch (e) {
       throw 'Unexpected error. Please try again.';
     }
   }

   // Send Email verification

   Future<void> sendEmailVerification() async{
     try {
        await _auth.currentUser?.sendEmailVerification();
     } on FirebaseAuthException catch (e) {
       throw TFirebaseAuthException(e.code).message;
     } on FirebaseException catch (e) {
       throw TFirebaseException(e.code).message;
     } on FormatException catch (_) {
       throw const TFormatException().message;
     } on PlatformException catch (e) {
       throw TPlatformException(e.code).message;
     } catch (e) {
       throw 'some thing went wrong. please try again';
     }
   }

   // Send Mobile Number OTP
   Future<void> sendOtpToPhoneNumber(String phoneNumber) async {
     try {
       TFullScreenLoader.openLoadingDialog('we are processing your application', WatterImages.docerAnimation);
       await _auth.verifyPhoneNumber(
         phoneNumber: phoneNumber,
         timeout: const Duration(seconds: 60),
         verificationCompleted: (PhoneAuthCredential credential) async {
           // Auto-verification works on some Android devices
           await _auth.signInWithCredential(credential);
           Get.offAll(() => const NavigationMenu());
         },
         verificationFailed: (FirebaseAuthException e) {
           throw TFirebaseAuthException(e.code).message;
         },
         codeSent: (String verificationId, int? resendToken) {
           // Pass this to OTP screen
           TFullScreenLoader.stopLoading();
           Get.to(() => EnterOtpScreen(
             phoneNumber: phoneNumber,
             verificationId: verificationId,
           ));
           TLoaders.successSnackBar(title: 'OTP Sent', message: 'Check your phone for the OTP.');
         },
         codeAutoRetrievalTimeout: (String verificationId) {
           // You can handle auto-retrieval timeout here
         },
       );
     } on FirebaseAuthException catch (e) {
       throw TFirebaseAuthException(e.code).message;
     } on FirebaseException catch (e) {
       throw TFirebaseException(e.code).message;
     } on PlatformException catch (e) {
       throw TPlatformException(e.code).message;
     } catch (_) {
       throw 'Something went wrong. Please try again.';
     }
   }

   // OTP verification
   Future<UserCredential> verifyOtpAndLogin({
     required String verificationId,
     required String smsCode,
   }) async {
     try {
       // Create the phone auth credential
       final credential = PhoneAuthProvider.credential(
         verificationId: verificationId,
         smsCode: smsCode,
       );

       // Sign in with the credential
       return await FirebaseAuth.instance.signInWithCredential(credential);

       // // Optional: Navigate user after successful login
       // final user = userCredential.user;
       // if (user != null) {
       //   // You can now navigate to home screen or do further checks
       //   Get.offAll(() => const NavigationMenu());
       // } else {
       //   throw 'Failed to sign in. Please try again.';
       // }

     } on FirebaseAuthException catch (e) {
       throw TFirebaseAuthException(e.code).message;
     } on FirebaseException catch (e) {
       throw TFirebaseException(e.code).message;
     } on PlatformException catch (e) {
       throw TPlatformException(e.code).message;
     } on FormatException {
       throw const TFormatException().message;
     } catch (e) {
       throw 'Something went wrong. Please try again.';
     }
   }

   /// Goggle LogIn

   Future<UserCredential> singInWithGoogle() async {
     try {
       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

       final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
       final credentials = GoogleAuthProvider.credential(
         accessToken: googleAuth?.accessToken,
         idToken: googleAuth?.idToken
       );
       return await _auth.signInWithCredential(credentials);
     } on FirebaseAuthException catch (e) {
       throw TFirebaseAuthException(e.code).message;
     } on FirebaseException catch (e) {
       throw TFirebaseException(e.code).message;
     } on FormatException {
       throw const TFormatException().message;
     } on PlatformException catch (e) {
       throw TPlatformException(e.code).message;
     } catch (_) {
       throw 'Something went wrong during registration.';
     }
   }

   /// logout
   Future<void> logout() async{
     try {
       await GoogleSignIn().signOut();
       await FirebaseAuth.instance.signOut();
       Get.offAll(()=> const LoginScreen());
     } on FirebaseAuthException catch (e) {
       throw TFirebaseAuthException(e.code).message;
     } on FirebaseException catch (e) {
       throw TFirebaseException(e.code).message;
     } on FormatException catch (_) {
       throw const TFormatException().message;
     } on PlatformException catch (e) {
       throw TPlatformException(e.code).message;
     } catch (e) {
       throw 'some thing went wrong. please try again';
     }
   }
}
