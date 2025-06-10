import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/order_model.dart';

class OrdersController extends GetxController {
  var userOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    print('userId ========>  $userId');
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    userOrders.value = snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()..['id'] = doc.id))
        .toList();
  }
}
