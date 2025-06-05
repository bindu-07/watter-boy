import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/common/widgets/rounded_container.dart';
import 'package:water_boy/features/profie/screens/address/add_new_address.dart';
import 'package:water_boy/features/profie/screens/address/single_address.dart';
import 'package:water_boy/utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/address/address_select_controller.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late final SelectAddressController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SelectAddressController()); // ✅ SAFE HERE
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: WatterColors.primary,
        onPressed: () async {
          await Get.to(() => const AddNewAddressScreen());
          controller.fetchAddresses(); // 🔁 refresh the list
        },
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() =>ListView.builder(
          padding: const EdgeInsets.all(WatterSizes.defaultSpace),
          itemCount: controller.addresses.length,
          itemBuilder: (_, index) {
            final address = controller.addresses[index];
            return SingleAddress(
              selectedAddress: address.isSelected,
              address: address,
              onDelete: () {
                Get.defaultDialog(
                  title: 'Delete Address?',
                  middleText: 'Are you sure you want to remove this address?',
                  confirm: ElevatedButton(
                    onPressed: () {
                      controller.deleteAddress(index);
                      Get.back();
                    },
                    child: const Text('Delete'),
                  ),
                  cancel: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                );
              },
              onSelect: () => controller.selectAddress(index),
            );
          },
        )
      ),
    );
  }
}
