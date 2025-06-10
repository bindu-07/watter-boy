import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../authentication/models/users/user_mode.dart';
import '../../models/order_model.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  UserModel? deliveryBoy;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDeliveryBoy();
  }

  Future<void> fetchDeliveryBoy() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(widget.order.deliveryBoyId).get();
    if (doc.exists) {
      setState(() {
        deliveryBoy = UserModel.fromSnapShot(doc);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    int currentStep = order.status;

    return Scaffold(
      appBar: const TAppBar(title: Text("Order Details"), showBackArrow: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(WatterSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order Info
            Card(
              child: ListTile(
                title: Text("Order ID: #${order.id}"),
                subtitle: Text("Placed on: ${DateFormat('d MMM y, h:mm a').format(order.createdAt)}"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Iconsax.receipt),
                    SizedBox(height: 4),
                    Text("Invoice"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: WatterSizes.defaultSpace),

            /// Order Progress
            Text("Order Status", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Stepper(
              currentStep: currentStep,
              controlsBuilder: (_, __) => const SizedBox.shrink(),
              steps: [
                Step(
                  title: const Text("Order Placed"),
                  content: Lottie.asset(WatterImages.orderPlacedAnimation, height: 100),
                  isActive: currentStep >= 0,
                  state: currentStep > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text("In Progress"),
                  content: Lottie.asset(WatterImages.orderInProgressAnimation, height: 100),
                  isActive: currentStep >= 1,
                  state: currentStep > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text("Out for Delivery"),
                  content: Lottie.asset(WatterImages.orderOutForDeliveryAnimation, height: 100),
                  isActive: currentStep >= 2,
                  state: currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text("Delivered"),
                  content: Lottie.asset(WatterImages.orderDeliveredAnimation, height: 100),
                  isActive: currentStep >= 3,
                  state: currentStep == 3 ? StepState.complete : StepState.indexed,
                ),
              ],
            ),

            const SizedBox(height: WatterSizes.defaultSpace),

            /// Items List
            Text("Items", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: order.items.map((item) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Iconsax.box),
                        title: Text(item.name),
                        trailing: Text("x${item.quantity}"),
                      ),
                      if (item != order.items.last) const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: WatterSizes.defaultSpace),

            /// Delivery Boy
            Text("Delivery Person", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (deliveryBoy != null)
              Card(
                child: ListTile(
                  leading: const Icon(Iconsax.user),
                  title: Text(deliveryBoy!.name!),
                  subtitle: Text("Phone: ${deliveryBoy!.phoneNumber}"),
                  trailing: IconButton(
                    icon: const Icon(Iconsax.call),
                    onPressed: () {
                      final phone = deliveryBoy!.phoneNumber;
                      launchUrl(Uri.parse("tel:$phone"));
                    },
                  ),
                ),
              ),

            const SizedBox(height: WatterSizes.defaultSpace),

            /// Delivery Address
            Text("Delivery Address", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Iconsax.location),
                title: Text(order.deliveryAddress.house),
              ),
            ),

            const SizedBox(height: WatterSizes.defaultSpace),

            /// Payment Summary
            Text("Summary", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Payment Mode"),
                    trailing: Text(order.paymentMode),
                  ),
                  ListTile(
                    title: const Text("Delivery Charge"),
                    trailing: Text("₹${order.deliveryCharge.toStringAsFixed(2)}"),
                  ),
                  ListTile(
                    title: const Text("Total Amount"),
                    trailing: Text(
                      "₹${order.totalAmount.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

