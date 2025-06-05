import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:water_boy/data/repository/user/address_repository.dart';
import 'package:water_boy/features/profie/models/address_model.dart';

import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance=>Get.find();
  final addressRepo = Get.put(AddressRepository());

  RxList<AddressModel> featuredAddress = <AddressModel>[].obs;
  // Form controllers
  final name = TextEditingController();
  final number = TextEditingController();
  final house = TextEditingController();
  final floor = TextEditingController();
  final landmark = TextEditingController();

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();


  /// Call this to add address
  Future<void> addNewAddress() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final address = AddressModel(
        receiverName: name.text.trim(),
        receiverNumber: number.text.trim(),
        house: house.text.trim(),
        floor: floor.text.trim(),
        landmark: landmark.text.trim(),
        isSelected: true,
        createdAt: DateTime.now(),
      );

      await AddressRepository.instance.addNewAddress(address);

      Get.back(); // Return to previous screen
      TLoaders.successSnackBar(title: 'Success', message: 'Address added successfully');
      clearForm();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    name.clear();
    number.clear();
    house.clear();
    floor.clear();
    landmark.clear();
  }
}
