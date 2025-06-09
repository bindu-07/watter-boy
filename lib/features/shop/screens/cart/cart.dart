import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_boy/features/shop/screens/checkout/checkout.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../controllers/cart_controller.dart';
import '../checkout/delivery_boy.dart';
import 'cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(WatterSizes.defaultSpace),
        child: CartItems(),
      ),
      bottomNavigationBar: Obx(() {
        final total = cartController.getTotalAmount();
        return Padding(
          padding: const EdgeInsets.all(WatterSizes.defaultSpace),
          child: ElevatedButton(
              onPressed: total != 0
                  ? () => Get.to(() => const DeliveryBoy())
                  : null,
              child: Text('Checkout ₹$total')),
        );
      }),
    );
  }
}
