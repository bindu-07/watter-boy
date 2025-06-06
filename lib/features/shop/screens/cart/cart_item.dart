import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/circular_icon.dart';
import 'package:water_boy/common/widgets/rounded_image.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../../../utils/helper/helper_function.dart';
import '../../controllers/cart_controller.dart';
import '../../models/product_model.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return const Center(child: Text("Cart is empty"));
      }
      return ListView.separated(
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: WatterSizes.spaceBtwSections),
        itemBuilder: (context, index) {
          final product = cartController.cartItems.keys.toList()[index];
          final quantity = cartController.cartItems[product]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartItem(product: product),
              const SizedBox(height: WatterSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProductQuantity(
                    quantity: quantity,
                    onAdd: () => cartController.addToCart(product),
                    onRemove: () => cartController.removeFromCart(product),
                  ),
                  Text(
                    '${int.parse(product.price) * quantity} ₹',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              )
            ],
          );
        },
      );
    });
  }
}

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
    required this.quantity,
    this.onAdd,
    this.onRemove,
    this.compact = false,
  });

  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final buttonSize = compact ? 26.0 : 32.0;
    final iconSize = compact ? WatterSizes.sm : WatterSizes.md;
    final spacing = compact ? 6.0 : WatterSizes.spaceBtwItems;

    return Row(
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          width: buttonSize,
          height: buttonSize,
          size: iconSize,
          color: WatterColors.white,
          backgroundColor: WatterColors.darkerGrey,
          onPressed: onRemove,
        ),
        SizedBox(width: spacing),
        Text(
          '$quantity',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: WatterSizes.spaceBtwItems,
        ),
        CircularIcon(
          icon: Iconsax.add,
          width: buttonSize,
          height: buttonSize,
          size: iconSize,
          color: WatterColors.white,
          backgroundColor: WatterColors.primary,
          onPressed: onAdd,
        ),
      ],
    );
  }
}



class CartItem extends StatelessWidget {
  final ProductModel product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          isNetworkImage: true,
          imgUrl: product.image,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(WatterSizes.sm),
          backgroundColor: WatterHelperFunction.isDarkMode(context)
              ? WatterColors.darkerGrey
              : WatterColors.light,
        ),
        const SizedBox(width: WatterSizes.spaceBtwItems),
        Expanded(
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }
}

