import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../shop/controllers/cart_controller.dart';
import '../../models/address_model.dart';

class SelectAddressController extends GetxController {
  static SelectAddressController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final RxList<AddressModel> addresses = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    try {
      // TFullScreenLoader.openLoadingDialog('we are fetching  your address', WatterImages.docerAnimation);

      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = doc.data();

      final List<dynamic> list = data?['addresses'] ?? [];

      final addressModels = list
          .map((e) => AddressModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
      print('object =======> ${addressModels.length}');
      addresses.assignAll(addressModels);
      // Set the selected address into CartController
      final selected = addresses.firstWhereOrNull((a) => a.isSelected);
      if (selected != null) {
        CartController.instance.selectedAddress.value = selected;
      }

      // TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      print('ERROR =======> ${e.toString()}');
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


  Future<void> deleteAddress(int index) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    addresses.removeAt(index);
    await _db.collection('users').doc(uid).update({
      'addresses': addresses.map((e) => e.toMap()).toList(),
    });
  }
  Future<void> selectAddress(int index) async {
    print('selectAddress');
    final uid = FirebaseAuth.instance.currentUser!.uid;

    for (int i = 0; i < addresses.length; i++) {
      addresses[i].isSelected = i == index;
    }

    await _db.collection('users').doc(uid).update({
      'addresses': addresses.map((e) => e.toMap()).toList(),
    });
    CartController.instance.selectedAddress.value = addresses[index];
    addresses.refresh();
  }

}
