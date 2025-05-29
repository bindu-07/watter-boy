import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/common/widgets/settings_menu_tile.dart';
import 'package:water_boy/features/profie/screens/address/address.dart';
import 'package:water_boy/features/profie/screens/orders/order.dart';
import 'package:water_boy/features/profie/screens/profile/profile.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import '../../../../common/widgets/rounded_image.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/home/home.dart';
import '../address/add_new_address.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    showBackArrow: true,
                    title: Text(
                      'Settings',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: WatterColors.white),
                    ),
                  ),

                  // User Profile Card
                  UserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(
                    height: WatterSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(WatterSizes.defaultSpace),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Account Settings',
                        style: Theme.of(context).textTheme.headlineSmall?.apply(
                            color: WatterHelperFunction.isDarkMode(context)
                                ? Colors.white
                                : WatterColors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: WatterSizes.spaceBtwSections,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subtitle: 'Set Delivery address',
                    onTab: () => Get.to(() => AddressScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Orders',
                    subtitle: 'In-progress and complete orders',
                    onTab: () => Get.to(() => OrdersScreen()),
                  ),
                  /*SettingsMenuTile(icon: Iconsax.safe_home, title: 'My Address', subtitle: 'Set Delivery address',trailing: Switch(value: false, onChanged: (value) {}),),*/
                  // Logout Button
                  const SizedBox(
                    height: WatterSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: WatterSizes.spaceBtwSections * 2.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TRoundedImage(
        imgUrl: WatterImages.userImage,
        applyImageRadius: true,
        width: 50,
        height: 50,
        borderRadius: 50,
      ),
      title: Text(
        'Bindu Hait',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.apply(color: WatterColors.white),
      ),
      subtitle: Text(
        '+91 9330373008',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.apply(color: WatterColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: WatterColors.white,
          )),
    );
  }
}
