import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../common/widgets/success_screen.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_string.dart';
import '../../authentication/models/users/user_mode.dart';
import 'cart_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> placeOrder() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      final cartController = CartController.instance;
      final selectedAddress = cartController.selectedAddress.value;
      final selectedDeliveryBoy = cartController.selectedDeliveryBoy.value;

      if (selectedAddress == null || selectedDeliveryBoy == null) {
        throw Exception('Address or Delivery boy not selected');
      }

      // Fetch user's location from Firestore (or cache if available)
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final currentUser = UserModel.fromSnapShot(userDoc);

      // Prepare cart item list
      final cartItems = cartController.cartItems.entries.map((e) {
        return {
          'productId': e.key.id,
          'name': e.key.name,
          'price': e.key.price,
          'quantity': e.value,
          'total': int.parse(e.key.price) * e.value,
        };
      }).toList();

      final itemsTotal = cartController.getTotalAmount();
      final distance = selectedDeliveryBoy.extraDistance ?? 0.0;
      final deliveryCharge = (selectedDeliveryBoy.baseCharge ?? 0) +
          ((selectedDeliveryBoy.perKmCharge ?? 0) * distance).round();
      final grandTotal = itemsTotal + deliveryCharge;

      // Create order map
      final orderData = {
        'userId': user.uid,
        'items': cartItems,
        'totalAmount': grandTotal,
        'deliveryBoyId': selectedDeliveryBoy.id,
        'deliveryCharge': deliveryCharge,
        'paymentMode': 'Pay on Delivery',
        'status': 0, // 0 = pending
        'userLocation': currentUser.location?.toMap(),
        'deliveryAddress': selectedAddress.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save to Firestore
      await _db.collection('orders').add(orderData);
      Get.to(() => SuccessScreen(
        image: WatterImages.successfulPaymentIcon,
        title: 'Payment Success',
        subTittle: 'Your Watter refile within 10 min',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));

    } catch (e) {
      print('Order placement error: $e');
      rethrow;
    }
  }
}
