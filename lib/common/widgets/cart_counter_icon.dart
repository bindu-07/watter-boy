
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/shop/controllers/cart_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helper/helper_function.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key, this.iconColor = WatterColors.white,  this.onPressed,
  });
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    final cartController = Get.put(CartController());

    return Obx(() {
      final itemCount = cartController.totalItemsCount.value;

      return Stack(
      children: [
        IconButton(
          onPressed: null,
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: dark? Colors.white: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Text('$itemCount', style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: dark? WatterColors.black: WatterColors.white, fontSizeFactor: 0.8),),
            ))
      ],
    );
    });
  }
}