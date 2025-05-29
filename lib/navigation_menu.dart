import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/features/shop/screens/cart/cart.dart';
import 'package:water_boy/features/shop/screens/home/home.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import 'common/widgets/cart_counter_icon.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = WatterHelperFunction.isDarkMode(context);
    return  Scaffold(
      bottomNavigationBar: Obx(
            ()=> NavigationBar(
          height: 80,
            elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=> controller.selectedIndex.value = index,
          backgroundColor: dark? WatterColors.black : WatterColors.white,
          indicatorColor: dark? WatterColors.white.withOpacity(0.1) : WatterColors.black.withOpacity(0.1),
          destinations: [
            const NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination( icon: CartCounterIcon(
             iconColor: dark? WatterColors.white : WatterColors.black,
            ), label: "Cart",),
        ],
        
        ),
      ),body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}


class NavigationController extends GetxController {

  final Rx<int> selectedIndex = 0.obs;
  final screens = [const HomeScreen(), const CartScreen(), Container(color: Colors.orange,)];
}