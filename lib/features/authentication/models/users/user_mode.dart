import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_boy/features/profie/models/address_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final int userType;
  final String countryCode;
  final String deviceToken;
  final String deviceType;
  final UserLocation? location;
  final List<AddressModel>? addresses;

  UserModel({ this.addresses,
       this.location,
      required this.userType,
      required this.countryCode,
      required this.deviceToken,
      required this.deviceType,
      required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  static UserModel empty() => UserModel(
      userType: 0,
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      countryCode: '',
      deviceToken: '',
      deviceType: '',
      location: null, addresses: []);

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'fullName': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'userType': userType,
      'countryCode': countryCode,
      'deviceToken': deviceToken,
      'deviceType': deviceType,
      'location': location?.toMap(),
      'addresses': addresses?.map((a) => a.toMap()).toList(),
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['fullName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        userType: data['userType'] ?? 0,
        countryCode: data['countryCode'] ?? '',
        deviceToken: data['deviceToken'] ?? '',
        deviceType: data['deviceType'] ?? '',
        location: data['location'] != null
            ? UserLocation.fromMap(data['location'])
            : null,
        addresses: (data['addresses'] as List)
            .map((a) => AddressModel.fromMap(a))
            .toList(),
      );
    } else {
      return UserModel.empty();
    }
  }

//factory Method to create a User model to a Firebase document snapshot
}

class UserLocation {
  final String fullAddress;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  UserLocation({
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  // Factory to create from Firestore
  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      fullAddress: map['fullAddress'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to Firestore format
  Map<String, dynamic> toMap() {
    return {
      'fullAddress': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': FieldValue.serverTimestamp(), // Firebase generates this
    };
  }
}


