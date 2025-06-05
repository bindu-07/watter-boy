import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../controllers/address/adress_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Add New Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(WatterSizes.defaultSpace),
          child: Form(
              key: controller.formKey,
              child: Column(
            children: [
              TextFormField(
                controller: controller.name,

                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Reciver\'s Name'),
                  validator: (value) => value!.isEmpty ? 'Name is required' : null
              ),
              SizedBox(
                height: WatterSizes.spaceBtwInputFields,
              ),
              TextFormField(
                  controller: controller.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Reciver\'s Number'),
                validator: (value) => value!.isEmpty ? 'Phone number is required' : null,
              ),
              SizedBox(
                height: WatterSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.house,
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'House / FLATE'),
                validator: (value) => value!.isEmpty ? 'House is required' : null,
              ),
              SizedBox(
                height: WatterSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.floor,
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'Floor (optional)'),
              ),
              SizedBox(
                height: WatterSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.landmark,
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'Landmark (optional)'),
              ),
              SizedBox(
                height: WatterSizes.spaceBtwInputFields,
              ),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.addNewAddress,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Save'),
                ),
              )),
            ],
          )),
        ),
      ),
    );
  }
}
