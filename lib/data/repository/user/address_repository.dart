
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:water_boy/features/profie/models/address_model.dart';

import '../../../features/shop/controllers/cart_controller.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();


  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addNewAddress(AddressModel address) async {
    try {
      final uid = AuthenticationRepository.instance.authUser?.uid;
      final docRef = await _db.collection('users').doc(uid).get();

      List<dynamic> currentAddresses = docRef.data()?['addresses'] ?? [];
      print('current addresses $currentAddresses');

      currentAddresses = currentAddresses.map((a) {
        final map = Map<String, dynamic>.from(a);
        map['isSelected'] = false;
        CartController.instance.selectedAddress.value = address;
        return map;
      }).toList();

      // Add the new address as selected
      currentAddresses.add(address.toMap());
      print('current addresses $currentAddresses');
      // Update Firestore
      await _db.collection('users').doc(uid).update({
        'addresses': currentAddresses,
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'some thing went wrong. please try again';
    }
  }

  Future<List<AddressModel>> fetchUserAddresses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data();

    final List<dynamic> list = data?['addresses'] ?? [];

    final addressModels = list
        .map((e) => AddressModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    print('object==================> ${addressModels}');
    return addressModels;
  }
}