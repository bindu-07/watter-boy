import 'package:get/get.dart';

import '../models/product_model.dart';


class CartController extends GetxController {
  static CartController get instance => Get.find();

  var cartItems = <ProductModel, int>{}.obs;

  void addToCart(ProductModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
  }

  void removeFromCart(ProductModel product) {
    if (!cartItems.containsKey(product)) return;
    if (cartItems[product] == 1) {
      cartItems.remove(product);
    } else {
      cartItems[product] = cartItems[product]! - 1;
    }
  }

  int getTotalAmount() {
    return cartItems.entries
        .map((entry) => int.parse(entry.key.price) * entry.value)
        .fold(0, (prev, curr) => prev + curr);
  }
}
