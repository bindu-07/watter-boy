import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../authentication/models/users/user_mode.dart';
import '../../profie/models/address_model.dart';
import '../models/product_model.dart';


class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Cart: Product -> Quantity
  var cartItems = <ProductModel, int>{}.obs;

  /// Selected Delivery Boy (optional until selected)
  Rxn<UserModel> selectedDeliveryBoy = Rxn<UserModel>();

  final Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);
  void setAddress(AddressModel address) {
    selectedAddress.value = address;
  }


  // Computed property for total item count
  RxInt get totalItemsCount => RxInt(
    cartItems.values.fold(0, (sum, itemCount) => sum + itemCount),
  );

  /// Total product price only (no delivery)
  int get totalProductAmount => cartItems.entries
      .map((entry) => int.parse(entry.key.price) * entry.value)
      .fold(0, (sum, itemTotal) => sum + itemTotal);

  /// Delivery charge based on selected boy
  int get deliveryCharge {
    final boy = selectedDeliveryBoy.value;
    if (boy == null) return 0;

    final base = boy.baseCharge ?? 0;
    final perKm = boy.perKmCharge ?? 0;
    final distance = boy.extraDistance ?? 0;

    return base + (perKm * distance).round();
  }

  /// Grand total = products + delivery
  int get grandTotal => totalProductAmount + deliveryCharge;


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

  void updateTotal() {
    _total.value = cartItems.values.fold(0, (sum, qty) => sum + qty);
  }
  void clearCart() {
    cartItems.clear();
  }

  bool isCartEmpty() => cartItems.isEmpty;

  void setSelectedDeliveryBoy(UserModel boy) {
    selectedDeliveryBoy.value = boy;
  }
}
