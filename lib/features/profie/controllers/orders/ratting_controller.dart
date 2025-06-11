import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../authentication/models/users/user_mode.dart';


class RatingController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> hasRated(String orderId) async {
    final doc = await _db.collection('ratings').doc(orderId).get();
    return doc.exists;
  }

  Future<void> submitRating(DeliveryRating rating) async {
    await _db.collection('ratings').doc(rating.orderId).set(rating.toMap());

    // Optionally: Update deliveryBoy's average rating
    final snapshot = await _db
        .collection('ratings')
        .where('deliveryBoyId', isEqualTo: rating.deliveryBoyId)
        .get();

    double avg = 0.0;
    if (snapshot.docs.isNotEmpty) {
      final ratings = snapshot.docs.map((doc) => doc['rating'] as double).toList();
      avg = ratings.reduce((a, b) => a + b) / ratings.length;
    }

    await _db.collection('users').doc(rating.deliveryBoyId).update({
      'ratting': avg,
    });
  }
  Future<void> saveFcmToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'deviceToken': token,
      });
    }
  }

}
