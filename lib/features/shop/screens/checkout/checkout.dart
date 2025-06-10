import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar.dart';
import '../../../../common/widgets/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../authentication/models/users/user_mode.dart';
import '../../../profie/controllers/address/address_select_controller.dart';
import '../../../profie/screens/address/add_new_address.dart';
import '../../../profie/screens/address/address.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../../models/product_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final selectedDeliveryBoy = cartController.selectedDeliveryBoy;
    final cartItems = cartController.cartItems;
    final addressController = Get.put(SelectAddressController());
    final selectedAddress = CartController.instance.selectedAddress;

    if (selectedDeliveryBoy == null) {
      return const Scaffold(
        body: Center(child: Text("No delivery boy selected.")),
      );
    }

    final deliveryDistance = selectedDeliveryBoy.value?.extraDistance ?? 0;
    final deliveryCharge = (selectedDeliveryBoy.value?.baseCharge ?? 0) +
        ((selectedDeliveryBoy.value?.perKmCharge ?? 0) * deliveryDistance)
            .round();

    final itemsTotal = cartController.getTotalAmount();
    final grandTotal = itemsTotal + deliveryCharge;

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Checkout"),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🛒 Cart Items
                  _buildSectionTitle("Items", context),
                  const SizedBox(height: 12),
                  ...cartItems.entries.map((entry) {
                    final ProductModel product = entry.key;
                    final int quantity = entry.value;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(child: Text('x$quantity')),
                        title: Text(product.name),
                        subtitle: Text("₹${product.price} each"),
                        trailing: Text(
                          "₹${int.parse(product.price) * quantity}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // 🚴 Delivery Boy Info
                  _buildSectionTitle("Delivery By", context),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            selectedDeliveryBoy.value?.profilePicture != null
                                ? NetworkImage(
                                    selectedDeliveryBoy.value!.profilePicture!)
                                : null,
                        child: selectedDeliveryBoy.value?.profilePicture == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(selectedDeliveryBoy.value?.name ?? "No Name"),
                      subtitle: Text(
                        "${selectedDeliveryBoy.value?.baseCharge} Base + ${selectedDeliveryBoy.value?.perKmCharge} /km",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${deliveryDistance.toStringAsFixed(1)} km"),
                          Text("₹$deliveryCharge",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 💳 Payment Method
                  _buildSectionTitle("Payment Method", context),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text("Pay on Delivery"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 📦 Order Summary
                  _buildSectionTitle("Summary", context),
                  const SizedBox(height: 8),
                  _buildSummaryRow("Items Total", "₹$itemsTotal", context),
                  _buildSummaryRow(
                      "Delivery Charges", "₹$deliveryCharge", context),
                  const Divider(),
                  _buildSummaryRow("Grand Total", "₹$grandTotal", context,
                      bold: true),

                  const SizedBox(height: 20),

                  // 🏠 Delivery Address
                  _buildSectionTitle("Delivery Address", context),
                  Obx(() {
                    final address = cartController.selectedAddress.value;
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                            address?.receiverName ?? "No address selected"),
                        subtitle: address != null
                            ? Text(
                                '${address.house}, ${address.floor}, ${address.landmark}')
                            : const Text('Please select a delivery address'),
                        trailing: TextButton(
                          onPressed: () => _showAddressBottomSheet(context),
                          child: const Text("Change"),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // ✅ Bottom CTA Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              final selectedAddress = cartController.selectedAddress.value;
              final deliveryBoy = cartController.selectedDeliveryBoy.value;

              final isPlaceOrderEnabled =
                  selectedAddress != null && deliveryBoy != null;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isPlaceOrderEnabled
                      ? () async {
                          final controller = Get.put(OrderController());
                          await controller.placeOrder();
                        }
                      : null,
                  icon: const Icon(Icons.check_circle),
                  label: const Text("Place Order"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, BuildContext context,
      {bool bold = false}) {
    final style = bold
        ? Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    final addressController = Get.put(SelectAddressController());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Obx(() {
        final addresses = addressController.addresses;
        if (addresses.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("No addresses found."),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await Get.to(() => const AddNewAddressScreen());
                    addressController.fetchAddresses();
                    Navigator.pop(context);
                  },
                  child: const Text("Add New Address"),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Delivery Address",
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              ...List.generate(addresses.length, (index) {
                final address = addresses[index];
                return ListTile(
                  title: Text(address.receiverName),
                  subtitle: Text(
                      '${address.house}, ${address.floor}, ${address.landmark}'),
                  leading: Icon(address.isSelected
                      ? Icons.check_circle
                      : Icons.location_on),
                  onTap: () async {
                    await addressController.selectAddress(index);
                    CartController.instance.selectedAddress.value = address;
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
