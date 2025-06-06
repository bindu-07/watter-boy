import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/common/widgets/circular_container.dart';
import 'package:water_boy/common/widgets/rounded_image.dart';
import 'package:water_boy/data/repository/user/user_repository.dart';
import 'package:water_boy/features/authentication/models/users/user_mode.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/device/device_utility.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helper/helper_function.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userModel});

  final Rx<UserModel> userModel;

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Profile',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: dark ? WatterColors.white : WatterColors.black),
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WatterSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TRoundedImage(
                      imgUrl: WatterImages.userImage,
                      width: 80,
                      height: 80,
                      borderRadius: 80,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              SizedBox(
                height: WatterSizes.spaceBtwSections / 2,
              ),
              Divider(),
              SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile Information',
                    style: Theme.of(context).textTheme.headlineSmall?.apply(
                        color: dark ? Colors.white : WatterColors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'Name',
                value: userModel.value.name,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: userModel.value.email,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: userModel.value.phoneNumber,
              ),
              const SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),
              const Divider(),
              const SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),
              Center(
                child: TextButton(
                    onPressed: () => UserRepository.instance.deleteUserData(userModel.value.id),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: WatterSizes.spaceBtwSections / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
                child: Icon(
              icon,
              size: 18,
            ))
          ],
        ),
      ),
    );
  }
}
