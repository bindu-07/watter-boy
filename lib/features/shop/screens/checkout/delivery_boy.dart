import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../common/widgets/appbar.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/models/users/user_mode.dart';
import '../../controllers/cart_controller.dart';
import 'checkout.dart';

class DeliveryBoy extends StatefulWidget {
  const DeliveryBoy({super.key});

  @override
  State<DeliveryBoy> createState() => _DeliveryBoyState();
}

class _DeliveryBoyState extends State<DeliveryBoy> {
  int? _selectedIndex;
  List<UserModel> _deliveryBoys = [];
  bool _loading = true;
  UserLocation? _userLocation;
  final cartController = CartController.instance;

  @override
  void initState() {
    super.initState();
    fetchUserAndDeliveryBoys();
  }

  Future<void> fetchUserAndDeliveryBoys() async {
    try {
      // Get current user data including location
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      final user = UserModel.fromSnapShot(userDoc);
      _userLocation = user.location;

      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("userType", isEqualTo: 1)
          .get();

      final List<UserModel> deliveryList = [];

      for (var doc in snapshot.docs) {
        final boy = UserModel.fromSnapShot(doc);

        // Calculate distance if both have location
        double distance = 0;
        if (_userLocation != null && boy.location != null) {
          distance = Geolocator.distanceBetween(
            _userLocation!.latitude,
            _userLocation!.longitude,
            boy.location!.latitude,
            boy.location!.longitude,
          ) /
              1000; // in KM
        }

        // Inject distance temporarily using a copy-like workaround
        deliveryList.add(boy.copyWith(extraDistance: distance));
      }

      setState(() {
        _deliveryBoys = deliveryList;
        _loading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Select Delivery Boy',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _deliveryBoys.isEmpty
          ? const Center(child: Text("No delivery boys available"))
          : SizedBox(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _deliveryBoys.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final boy = _deliveryBoys[index];
            final isSelected = _selectedIndex == index;

            return _buildDeliveryBoyCard(boy, isSelected, () {
              setState(() => _selectedIndex = index);
              // Optionally store selectedUser in controller:
              cartController.selectedDeliveryBoy.value = boy;
            });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(WatterSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: _selectedIndex != null
              ? () => Get.to(() => const CheckoutScreen())
              : null,
          child: Text('Continue'),
        ),
      ),
    );
  }

  Widget _buildDeliveryBoyCard(UserModel boy, bool isSelected, VoidCallback onTap) {
    final theme = Theme.of(context);
    final distance = (boy.extraDistance ?? 0.0).toStringAsFixed(2);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.1)
              : theme.cardColor,
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 32,
              backgroundImage: boy.profilePicture?.isNotEmpty == true
                  ? NetworkImage(boy.profilePicture!)
                  : null,
              child: boy.profilePicture == null || boy.profilePicture!.isEmpty
                  ? Icon(Icons.person, size: 32, color: colorScheme.onBackground)
                  : null,
            ),
            const SizedBox(width: 16),

            // Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(boy.name ?? 'No Name',
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    boy.isAvailable == true ? '🟢 Available' : '🔴 Unavailable',
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: boy.isAvailable == true
                            ? Colors.green
                            : Colors.red),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _infoTag('Base: ₹${boy.baseCharge ?? 0}', context),
                      const SizedBox(width: 8),
                      _infoTag('Per KM: ₹${boy.perKmCharge ?? 0}', context),
                      const SizedBox(width: 8),
                      _infoTag('Per Floor: ₹${boy.perFloreCharge ?? 0}', context),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: colorScheme.primary),
                      Text('$distance km away',
                          style: theme.textTheme.bodySmall),
                      const SizedBox(width: 12),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      Text('${boy.ratting ?? "N/A"}',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),

            // if (isSelected)
            //   Icon(Icons.check_circle, color: colorScheme.primary, size: 28),
          ],
        ),
      ),
    );
  }


  Widget _infoTag(String text, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall,
      ),
    );
  }


}

