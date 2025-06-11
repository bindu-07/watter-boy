import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_boy/utils/theme/theme.dart';


import 'App.dart';
import 'data/repository/authentication/authentication_repository.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Add widget binding
  print('start1');
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // local storage
  print('start2');
  await GetStorage.init();
  // await Splash until others items load
  print('start3');
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //initialize Firebase and Authentication Repository
  print('start4');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Force sign out on fresh install
  // await FirebaseAuth.instance.signOut();
  // Put your controller BEFORE runApp
  Get.put(AuthenticationRepository());

  FlutterNativeSplash.remove(); // ✅ Move this here
  print('start5');
  runApp(const App());
}

