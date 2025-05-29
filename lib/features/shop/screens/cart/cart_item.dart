import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/circular_icon.dart';
import 'package:water_boy/common/widgets/rounded_image.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../../../utils/helper/helper_function.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) => Column(
        children: [
          const CartItem(),
          if (showAddRemoveButton)
            const SizedBox(
              height: WatterSizes.spaceBtwItems,
            ),
          if (showAddRemoveButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    ProductQuantity(),
                  ],
                ),
                Text('\$ 45',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.apply(decoration: null))
              ],
            )
        ],
      ),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(
        height: WatterSizes.spaceBtwSections,
      ),
    );
  }
}

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: WatterSizes.md,
          color: WatterHelperFunction.isDarkMode(context)
              ? WatterColors.white
              : WatterColors.black,
          backgroundColor: WatterHelperFunction.isDarkMode(context)
              ? WatterColors.darkerGrey
              : WatterColors.light,
          onPressed: () {},
        ),
        const SizedBox(
          width: WatterSizes.spaceBtwItems,
        ),
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: WatterSizes.spaceBtwItems,
        ),
        CircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: WatterSizes.md,
          color: WatterColors.white,
          backgroundColor: WatterColors.primary,
          onPressed: () {},
        ),
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///Image
        TRoundedImage(
          imgUrl: WatterImages.productImage,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(WatterSizes.sm),
          backgroundColor: WatterHelperFunction.isDarkMode(context)
              ? WatterColors.darkerGrey
              : WatterColors.light,
        ),
        SizedBox(
          width: WatterSizes.spaceBtwItems,
        ),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  'black Shoe jijvidjbjdlfdk d ',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),

              /// Attribute
              /*         Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Color ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: 'Green',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]))*/
            ],
          ),
        )
      ],
    );
  }
}
