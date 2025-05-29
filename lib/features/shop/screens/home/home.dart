import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/styles/shadows.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/common/widgets/curved_widget.dart';
import 'package:water_boy/common/widgets/rounded_container.dart';
import 'package:water_boy/common/widgets/rounded_image.dart';
import 'package:water_boy/features/profie/screens/settings/settings.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/device/device_utility.dart';

import '../../../../common/widgets/cart_counter_icon.dart';
import '../../../../common/widgets/circular_container.dart';
import '../../../../common/widgets/curve_edge_widget.dart';
import '../../../../utils/helper/helper_function.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PrimaryHeaderContainer(
              child: Column(
                children: [
                  HomeAppbar(),
                  SizedBox(
                    height: WatterSizes.spaceBtwSections,
                  ),
                  SearchContainer(),
                  SizedBox(
                    height: WatterSizes.spaceBtwSections * 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(WatterSizes.defaultSpace),
              child: Column(
                children: [
                  GridView.builder(itemCount: 6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 288,
                        crossAxisSpacing: WatterSizes.gridViewSpacing,
                        mainAxisSpacing: WatterSizes.gridViewSpacing),
                    itemBuilder: (_, index) => ProductCardVertical(),
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

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(WatterSizes.productImageRadius),
            color: dark ? WatterColors.darkGrey : WatterColors.white),
        child: Column(
          children: [
            //// Thumbnail
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(WatterSizes.sm),
              backgroundColor: dark ? WatterColors.dark : WatterColors.light,
              child: Stack(
                children: [
                  const TRoundedImage(
                    imgUrl: WatterImages.productImage,
                    applyImageRadius: true,
                  ),

                  /// Sale tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      height: WatterSizes.lg,
                      backgroundColor: WatterColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: WatterSizes.sm, vertical: WatterSizes.xs),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: WatterColors.black),
                      ),
                    ),
                  ),

                  /// favourite Icon button
                  /*Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: dark
                              ? WatterColors.black.withOpacity(0.9)
                              : WatterColors.white.withOpacity(0.9)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Iconsax.heart5,
                            color: Colors.red,
                          )),
                    ),
                  )*/
                ],
              ),
            ),

            const SizedBox(
              height: WatterSizes.spaceBtwItems / 2,
            ),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: WatterSizes.sm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Green Nike Air',
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: WatterSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// price
                      Text(
                        '\$10',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: WatterColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(WatterSizes.cardRadiusMd),
                                bottomRight: Radius.circular(
                                    WatterSizes.productImageRadius))),
                        child: const SizedBox(
                            width: WatterSizes.iconLg * 1.2,
                            height: WatterSizes.iconLg * 1.2,
                            child: Center(
                              child: Icon(
                                Iconsax.add,
                                color: WatterColors.white,
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: WatterSizes.defaultSpace),
      child: Container(
        width: WatterDeviceUtils.getScreenWidth(context),
        padding: EdgeInsets.all(WatterSizes.md),
        decoration: BoxDecoration(
            color: dark ? WatterColors.dark : WatterColors.light,
            borderRadius: BorderRadius.circular(WatterSizes.cardRadiusLg),
            border: Border.all(color: WatterColors.grey)),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal,
              color: WatterColors.darkerGrey,
            ),
            SizedBox(
              width: WatterSizes.spaceBtwItems,
            ),
            Text(
              'Search here',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_pin,
                  color: Colors.red, size: 24), // Front icon

              TextButton(
                onPressed: () {},
                child: Text(
                  "Singur",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: WatterColors.white),
                ),
              ),
              const Icon(Icons.arrow_drop_down,
                  color: Colors.white, size: 24), // End icon
            ],
          ),
          Text(
            "Singur, Hooghly, WestBengal, india",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: WatterColors.white),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () =>Get.to(()=> const SettingsScreen()),
            icon: const Icon(
              CupertinoIcons.profile_circled,
              size: 36,
            ))
      ],
    );
  }
}

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: WatterColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: TCircularWidget(
                  backgroundColor: WatterColors.textWhite.withOpacity(0.1),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularWidget(
                  backgroundColor: WatterColors.textWhite.withOpacity(0.1),
                )),
            child
          ],
        ),
      ),
    );
  }
}
