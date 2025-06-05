import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String receiverName;
  final String receiverNumber;
  final String house;
  final String floor;
  final String landmark;
  final bool isSelected;
  final DateTime createdAt;

  AddressModel({
    required this.receiverName,
    required this.receiverNumber,
    required this.house,
    required this.floor,
    required this.landmark,
    required this.isSelected,
    required this.createdAt,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      receiverName: map['receiverName'],
      receiverNumber: map['receiverNumber'],
      house: map['house'],
      floor: map['floor'],
      landmark: map['landmark'],
      isSelected: map['isSelected'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverName': receiverName,
      'receiverNumber': receiverNumber,
      'house': house,
      'floor': floor,
      'landmark': landmark,
      'isSelected': isSelected,
      'createdAt': Timestamp.fromDate(createdAt)
    };
  }
}
