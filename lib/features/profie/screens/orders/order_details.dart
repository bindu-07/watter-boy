import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../../../utils/constants/image_string.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  final int currentStep = 3; // 0: Placed, 1: In Progress, 2: Out for Delivery, 3: Delivered

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Order Details"), showBackArrow: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(WatterSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order Info
            Card(
              child: ListTile(
                title: const Text("Order ID: #WTR-239840"),
                subtitle: const Text("Placed on: May 18, 2025"),
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

            /// Items Summary
            Text("Items", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Iconsax.box),
                    title: const Text("Mineral Water - 20L"),
                    trailing: const Text("x2"),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Iconsax.box),
                    title: const Text("Mineral Water - 5L"),
                    trailing: const Text("x1"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: WatterSizes.defaultSpace),

            /// Total Summary
            Card(
              child: ListTile(
                title: const Text("Total Amount"),
                trailing: Text("₹210", style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
