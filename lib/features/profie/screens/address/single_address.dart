import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import '../../../../common/widgets/rounded_container.dart';
import '../../models/address_model.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress, required this.address, required this.onDelete, required this.onSelect});

  final bool selectedAddress;
  final AddressModel address;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: onSelect,
      child: TRoundedContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(WatterSizes.md),
        margin: const EdgeInsets.only(bottom: WatterSizes.spaceBtwItems),
        showBorder: true,
        borderColor: selectedAddress
            ? Colors.transparent
            : (dark ? WatterColors.darkerGrey : WatterColors.grey),
        backgroundColor: selectedAddress
            ? WatterColors.primary.withOpacity(0.1)
            : Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              selectedAddress ? Iconsax.tick_circle : Iconsax.location,
              color: selectedAddress
                  ? WatterColors.primary
                  : dark
                  ? Colors.white
                  : Colors.black,
              size: 28,
            ),
            const SizedBox(width: WatterSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.receiverName,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('📞 ${address.receiverNumber}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${address.house}, ${address.floor}, ${address.landmark}',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Iconsax.trash, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
