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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items
            Text("Items", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...cartItems.entries.map((entry) {
              final ProductModel product = entry.key;
              final int quantity = entry.value;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(product.name),
                subtitle: Text("₹${product.price} x $quantity"),
                trailing: Text("₹${int.parse(product.price) * quantity}"),
              );
            }),

            const Divider(height: 32),

            // Delivery Boy Info
            Text("Delivery By", style: Theme.of(context).textTheme.titleLarge),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: selectedDeliveryBoy.value?.profilePicture !=
                        null
                    ? NetworkImage(selectedDeliveryBoy.value!.profilePicture!)
                    : null,
                child: selectedDeliveryBoy.value?.profilePicture == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(selectedDeliveryBoy.value?.name ?? "No Name"),
              subtitle: Text(
                "${selectedDeliveryBoy.value?.baseCharge} Base + ${selectedDeliveryBoy.value?.perKmCharge} /km",
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${deliveryDistance.toStringAsFixed(1)} km"),
                  Text("₹$deliveryCharge",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const Divider(height: 32),

            // Payment Info
            Text("Payment Method",
                style: Theme.of(context).textTheme.titleLarge),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.money),
              title: Text("Pay on Delivery"),
            ),

            const Divider(height: 32),

            // Summary
            Text("Summary", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _buildSummaryRow("Items Total", "₹$itemsTotal", context),
            _buildSummaryRow("Delivery Charges", "₹$deliveryCharge", context),
            const SizedBox(height: 8),
            _buildSummaryRow("Grand Total", "₹$grandTotal", context,
                bold: true),
            // Delivery Address
            const Divider(height: 32),
            Text("Delivery Address", style: Theme.of(context).textTheme.titleLarge),
            Obx(() {
              final address = cartController.selectedAddress.value;
              return ListTile(
                title: Text(address?.receiverName ?? "No address selected"),
                subtitle: address != null
                    ? Text('${address.house}, ${address.floor}, ${address.landmark}')
                    : const Text('Please select a delivery address'),
                trailing: TextButton(
                  onPressed: () => _showAddressBottomSheet(context),
                  child: const Text("Change"),
                ),
              );
            }),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: cartController.selectedAddress.value == null
                  ? null
                  : () => Get.to(() => SuccessScreen(
                image: WatterImages.successfulPaymentIcon,
                title: 'Payment Success',
                subTittle: 'Your Watter will be refilled within 10 min',
                onPressed: () => Get.offAll(() => const NavigationMenu()),
              )),
              icon: const Icon(Icons.check_circle),
              label: const Text("Place Order"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
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
              const Text("Select Delivery Address", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              ...List.generate(addresses.length, (index) {
                final address = addresses[index];
                return ListTile(
                  title: Text(address.receiverName),
                  subtitle: Text('${address.house}, ${address.floor}, ${address.landmark}'),
                  leading: Icon(address.isSelected ? Icons.check_circle : Icons.location_on),
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


}
