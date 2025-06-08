import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {

  final String id;
  final String name;
  final String image;
  final bool isActive;
  final String price;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
    required this.price
  });

  static ProductModel empty() => ProductModel(id: '', name: '', image: '', isActive: true, price: '');

  /// convert model to JSON structure for storing data in Firebase
  toJson(){
    return {
      'id' : id,
      'image' : image,
      'isActive': isActive,
      'name': name,
      'price': price
    };
  }

  factory ProductModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null) return ProductModel.empty();
    final data = document.data()!;
      return ProductModel(
          id: data['id']?? '',
          name: data['name']?? '',
          isActive: data['isActive']?? true,
          price: data['price']?? '',
          image: data['image']?? ''
      );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ProductModel && other.id == id);

  @override
  int get hashCode => id.hashCode;

//factory Method to create a User model to a Firebase document snapshot

}