import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_boy/features/profie/models/address_model.dart';
import 'package:water_boy/features/shop/models/product_model.dart';

import '../../authentication/models/users/user_mode.dart';
import '../../shop/models/cart_item_model.dart';
import '../../shop/screens/cart/cart_item.dart';


class OrderModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final double totalAmount;
  final String deliveryBoyId;
  final int deliveryCharge;
  final String paymentMode;
  final int status; // 0: placed, 1: in progress, 2: out for delivery, 3: delivered
  final UserLocation? userLocation;
  final AddressModel deliveryAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.deliveryBoyId,
    required this.deliveryCharge,
    required this.paymentMode,
    required this.status,
    required this.userLocation,
    required this.deliveryAddress,
    required this.createdAt,
  });

  /// Factory method to create OrderModel from Firestore data
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      items: (map['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromMap(item))
          .toList(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      deliveryBoyId: map['deliveryBoyId'] ?? '',
      deliveryCharge: map['deliveryCharge'] ?? 0,
      paymentMode: map['paymentMode'] ?? '',
      status: map['status'] ?? 0,
      userLocation: map['userLocation'] != null
          ? UserLocation.fromMap(map['userLocation'])
          : null,
      deliveryAddress: AddressModel.fromMap(map['deliveryAddress']),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Convert OrderModel to JSON for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'deliveryBoyId': deliveryBoyId,
      'deliveryCharge': deliveryCharge,
      'paymentMode': paymentMode,
      'status': status,
      'userLocation': userLocation?.toMap(),
      'deliveryAddress': deliveryAddress.toMap(),
      'createdAt': createdAt,
    };
  }

  /// For empty fallback
  static OrderModel empty() => OrderModel(
    id: '',
    userId: '',
    items: [],
    totalAmount: 0,
    deliveryBoyId: '',
    deliveryCharge: 0,
    paymentMode: '',
    status: 0,
    userLocation: null,
    deliveryAddress: AddressModel.empty(),
    createdAt: DateTime.now(),
  );
}
