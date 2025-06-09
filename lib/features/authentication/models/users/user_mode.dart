import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_boy/features/profie/models/address_model.dart';

class UserModel {
  final String id;
  final String? name;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final int userType;
  final String countryCode;
  final String deviceToken;
  final String deviceType;
  final UserLocation? location;
  final List<AddressModel>? addresses;
  final bool? isAvailable;
  final int? baseCharge;
  final int? perFloreCharge;
  final int? perKmCharge;
  double? extraDistance;
  final String? ratting;

  UserModel(
      {this.isAvailable,
      this.baseCharge,
      this.perFloreCharge,
      this.perKmCharge,
      this.addresses,
      this.location,
      required this.userType,
      required this.countryCode,
      required this.deviceToken,
      required this.deviceType,
      required this.id,
      this.name,
      required this.email,
      required this.phoneNumber,
      this.profilePicture,
        this.extraDistance,
      this.ratting});

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
      location: null,
      addresses: [],);

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
      'isAvailable': isAvailable,
      'baseCharge': baseCharge,
      'ratting': ratting,
      'perFloreCharge': perFloreCharge,
      'perKmCharge': perKmCharge,
      'addresses': addresses?.map((a) => a.toMap()).toList(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    int? userType,
    String? countryCode,
    String? deviceToken,
    String? deviceType,
    UserLocation? location,
    List<AddressModel>? addresses,
    bool? isAvailable,
    int? baseCharge,
    int? perFloreCharge,
    int? perKmCharge,
    double? extraDistance,
    String? ratting,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      userType: userType ?? this.userType,
      countryCode: countryCode ?? this.countryCode,
      deviceToken: deviceToken ?? this.deviceToken,
      deviceType: deviceType ?? this.deviceType,
      location: location ?? this.location,
      addresses: addresses ?? this.addresses,
      isAvailable: isAvailable ?? this.isAvailable,
      baseCharge: baseCharge ?? this.baseCharge,
      perFloreCharge: perFloreCharge ?? this.perFloreCharge,
      perKmCharge: perKmCharge ?? this.perKmCharge,
      extraDistance: extraDistance ?? this.extraDistance,
      ratting: ratting?? this.ratting
    );
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
        profilePicture: data['ProfilePicture'] ?? '',
        userType: data['userType'] ?? 0,
        countryCode: data['countryCode'] ?? '',
        deviceToken: data['deviceToken'] ?? '',
        deviceType: data['deviceType'] ?? '',
        isAvailable: data['isAvailable'] ?? true,
        baseCharge: data['baseCharge'] ?? 0,
        perFloreCharge: data['perFloreCharge'] ?? 0,
        ratting: data['ratting']??'',
        perKmCharge: data['perKmCharge'] ?? 0,
        location: data['location'] != null
            ? UserLocation.fromMap(data['location'])
            : null,
        addresses: (data['addresses'] as List<dynamic>?)
                ?.map((a) => AddressModel.fromMap(a))
                .toList() ??
            [],
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
