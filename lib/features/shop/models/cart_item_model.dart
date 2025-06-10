class CartItemModel {
  final String productId;
  final String name;
  final int quantity;
  final String price;
  final int total;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price']) ?? "0",
      total: map['total'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}
