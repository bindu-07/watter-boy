import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String latitude;
  final String longitude;

  UserModel({required this.latitude, required this.longitude, required this.userType, required this.countryCode, required this.deviceToken, required this.deviceType,
      required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  static UserModel empty() => UserModel(
      userType: 0,id: '', name: '', email: '', phoneNumber: '', profilePicture: '', countryCode: '', deviceToken: '', deviceType: '', latitude: '', longitude: '');

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
      'latitude': latitude,
      'longitude': longitude
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
          latitude: data['latitude'] ?? '',
          longitude: data['longitude'] ?? '');

    } else {
      return UserModel.empty();
    }
  }

//factory Method to create a User model to a Firebase document snapshot
}
