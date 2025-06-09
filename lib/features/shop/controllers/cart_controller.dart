import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_model.dart';


class CartController extends GetxController {
  static CartController get instance => Get.find();

  var cartItems = <ProductModel, int>{}.obs;

  // Computed property for total item count
  RxInt get totalItemsCount => RxInt(
    cartItems.values.fold(0, (sum, itemCount) => sum + itemCount),
  );

  void addToCart(ProductModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    updateTotal();
  }

  void removeFromCart(ProductModel product) {
    if (!cartItems.containsKey(product)) return;
    if (cartItems[product] == 1) {
      cartItems.remove(product);
    } else {
      cartItems[product] = cartItems[product]! - 1;
    }
    updateTotal();
  }

  int getTotalAmount() {
    return cartItems.entries
        .map((entry) => int.parse(entry.key.price) * entry.value)
        .fold(0, (prev, curr) => prev + curr);
  }

  final RxInt _total = 0.obs;
  RxInt get total => _total;

  get selectedDeliveryBoy => null;

  void updateTotal() {
    _total.value = cartItems.values.fold(0, (sum, qty) => sum + qty);
  }
}
