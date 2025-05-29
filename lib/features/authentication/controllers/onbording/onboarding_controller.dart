import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_boy/features/authentication/screens/login/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // variables
  final pageController = PageController();
  Rx<int > currentPageIndex = 0.obs;
  Timer? _timer;
  final int totalPages = 3;
  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage = (pageController.page?.round() ?? 0) + 1;
      if (nextPage >= totalPages) nextPage = 0;

      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
/// Update current Index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Update current Index when page scroll
  void dotNavigationClicked(index){
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Update current Index when page scroll
  void nextPage(){
    if(currentPageIndex.value == 2) {
      // Login Page
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      print("page $page ${currentPageIndex.value}");
      pageController.jumpToPage(page);
    }
  }

  /// Upd
  void skipPage(){
    final storage = GetStorage();
    storage.write('IsFirstTime', false);
    Get.offAll(const LoginScreen());
    /*currentPageIndex.value = 2;
    pageController.jumpToPage(2);*/
  }

}
