import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_boy/binding/general_binding.dart';
import 'package:water_boy/features/authentication/screens/onboarding/onboarding.dart';
import 'package:water_boy/utils/theme/theme.dart';

import 'App.dart';
import 'main.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: WatterAppTheme.lightTheme,
      darkTheme: WatterAppTheme.darkTheme,
      initialBinding: GeneralBinding(),
      home: const Scaffold(
        body: Center(child: CircularProgressIndicator()), // or Container()
      ),
    );
  }
}
