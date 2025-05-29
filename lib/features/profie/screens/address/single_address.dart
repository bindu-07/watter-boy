import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import '../../../../common/widgets/rounded_container.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(WatterSizes.md),
      backgroundColor: selectedAddress
          ? WatterColors.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? WatterColors.darkerGrey
              : WatterColors.grey,
      margin: const EdgeInsets.only(top: WatterSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                  ? dark
                      ? WatterColors.light
                      : WatterColors.dark
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bindu hait',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: WatterSizes.sm,
              ),
              Text(
                'Phone Number: +91 9330373008',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: WatterSizes.sm ,
              ),
              const Text(
                'Singur, Hooghly, hait para, 712223, mollasimla',
                softWrap: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
