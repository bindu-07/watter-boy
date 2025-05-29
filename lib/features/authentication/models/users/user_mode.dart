import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture
});

  static UserModel empty() => UserModel(id: '', name: '', email: '', phoneNumber: '', profilePicture: '');

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson(){
    return {
      'Name' : name,
      'Email' : email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture
    };
  }

  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          name: data['Name']?? '',
          email: data['Email']?? '',
          phoneNumber: data['PhoneNumber']?? '',
          profilePicture: data['ProfilePicture']?? ''
      );
    } else {
      return UserModel.empty();
    }
  }

  //factory Method to create a User model to a Firebase document snapshot

}