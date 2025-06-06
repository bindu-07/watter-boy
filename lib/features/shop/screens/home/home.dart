import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/styles/shadows.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/common/widgets/curved_widget.dart';
import 'package:water_boy/common/widgets/rounded_container.dart';
import 'package:water_boy/common/widgets/rounded_image.dart';
import 'package:water_boy/features/profie/screens/settings/settings.dart';
import 'package:water_boy/features/shop/controllers/product_controller.dart';
import 'package:water_boy/features/shop/models/product_model.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/device/device_utility.dart';

import '../../../../common/widgets/cart_counter_icon.dart';
import '../../../../common/widgets/circular_container.dart';
import '../../../../common/widgets/curve_edge_widget.dart';
import '../../../../common/widgets/location_picker_screen.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../authentication/models/users/user_mode.dart';
import '../../controllers/cart_controller.dart';
import '../cart/cart_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PrimaryHeaderContainer(
              child: Column(
                children: [
                  LocationAppBar(),
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
                  Obx(
                    () {
                      if (controller.featuredProduct.isEmpty) {
                        return Center(
                            child: Text('No data found',
                                style: Theme.of(context).textTheme.bodyMedium));
                      }
                      return GridView.builder(
                        itemCount: controller.featuredProduct.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 288,
                                crossAxisSpacing: WatterSizes.gridViewSpacing,
                                mainAxisSpacing: WatterSizes.gridViewSpacing),
                        itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.featuredProduct[index]),
                      );
                    },
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
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final isDark = WatterHelperFunction.isDarkMode(context);

    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: isDark ? WatterColors.darkGrey : WatterColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Discount Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: TRoundedImage(
                  imgUrl: product.image,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  isNetworkImage: true,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "25% OFF",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Text(
                      '₹${product.price}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: WatterColors.primary,
                      ),
                    ),

                    // Cart Actions
                    Obx(() {
                      final quantity = cartController.cartItems[product] ?? 0;

                      return quantity > 0
                          ? ProductQuantity(
                        quantity: quantity,
                        onAdd: () => cartController.addToCart(product),
                        onRemove: () => cartController.removeFromCart(product),
                        compact: false,
                      )
                          : Container(
                        decoration: BoxDecoration(
                          color: WatterColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Iconsax.add, color: Colors.white),
                          onPressed: () => cartController.addToCart(product),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
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

/*class HomeAppbar extends StatelessWidget {
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
            onPressed: () => Get.to(() => const SettingsScreen()),
            icon: const Icon(
              CupertinoIcons.profile_circled,
              size: 36,
              color: Colors.white,
            ))
      ],
    );
  }
}*/

class LocationAppBar extends StatefulWidget {
  const LocationAppBar({super.key});

  @override
  State<LocationAppBar> createState() => _LocationAppBarState();
}

class _LocationAppBarState extends State<LocationAppBar> {
  String _location = "Fetching location...";
  String _shortLocation = "Location";

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      // Request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get placemarks (address)
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final fullAddress =
            "${place.subAdministrativeArea}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

        final location = UserLocation(
          fullAddress: fullAddress,
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp:
              DateTime.now(), // not used in Firestore, just for local reference
        );

        final userRepo = Get.put(UserRepository());
        await userRepo.updateSingleFiled({
          'location': location.toMap(),
        });
        setState(() {
          _location = fullAddress;
          _shortLocation = place.subLocality ?? "Location";
        });
      }
    } catch (e) {
      setState(() {
        _location = "Unable to get location";
        _shortLocation = "Unknown";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_pin, color: Colors.red, size: 24),
              TextButton(
                onPressed: () => _fetchLocation(),
                child: Text(
                  _shortLocation,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: WatterColors.white),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white, size: 24),
            ],
          ),
          Text(
            _location,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: WatterColors.white),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(() => const SettingsScreen()),
          icon: const Icon(CupertinoIcons.profile_circled,
              size: 36, color: Colors.white),
        )
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
