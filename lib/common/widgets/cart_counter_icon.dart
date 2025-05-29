
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
              child: Text('2', style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: dark? WatterColors.black: WatterColors.white, fontSizeFactor: 0.8),),
            ))
      ],
    );
  }
}