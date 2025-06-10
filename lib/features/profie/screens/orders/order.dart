import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:water_boy/common/widgets/rounded_container.dart';
import 'package:water_boy/features/profie/screens/orders/order_details.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import '../../../../common/widgets/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/orders/orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'My Orders',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(WatterSizes.defaultSpace),
        child: OrderListItem()
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    final controller = Get.put(OrdersController());
    String formatDate(DateTime dateTime) {
      return DateFormat('d MMM y h:mm a').format(dateTime);
    }
    return Obx(() {
      if (controller.userOrders.isEmpty) {
        return const Center(child: Text("No orders found."));
      }
      return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.userOrders.length,
        separatorBuilder: (_, __) =>
            SizedBox(height: WatterSizes.spaceBtwItems,),
        itemBuilder: (_, index) {
          final order = controller.userOrders[index];
          return TRoundedContainer(
            showBorder: true,
            padding: EdgeInsets.all(WatterSizes.md),
            backgroundColor: dark ? WatterColors.dark : WatterColors.light,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.ship,
                    ),
                    SizedBox(
                      width: WatterSizes.spaceBtwItems / 2,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${getStatusText(order.status)}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: WatterColors.primary,
                                fontWeightDelta: 1),
                          ),
                          Text('${formatDate(order.createdAt)}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium,)
                        ],
                      ),
                    ),

                    IconButton(onPressed: () =>
                        Get.to(() => OrderDetailsPage(order: order)),
                        icon: Icon(
                          Iconsax.arrow_right_34, size: WatterSizes.iconSm,))
                  ],
                ),

                const SizedBox(height: WatterSizes.spaceBtwItems,),

                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.tag,
                          ),
                          SizedBox(
                            width: WatterSizes.spaceBtwItems / 2,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Items',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .labelMedium!
                                ),
                                Text('${order.items.length}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.money,
                          ),
                          SizedBox(
                            width: WatterSizes.spaceBtwItems / 2,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Total',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .labelMedium!
                                ),
                                Text('₹${order.totalAmount.toStringAsFixed(2)}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    });
  }
  String getStatusText(int status) {
    switch (status) {
      case 0: return "Placed";
      case 1: return "In Progress";
      case 2: return "Out for Delivery";
      case 3: return "Delivered";
      default: return "Unknown";
    }
  }
}

// class OrderListItem extends StatelessWidget {
//   const OrderListItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OrdersController());
//
//     return Obx(() {
//       if (controller.userOrders.isEmpty) {
//         return const Center(child: Text("No orders found."));
//       }
//
//       return ListView.separated(
//         shrinkWrap: true,
//         itemCount: controller.userOrders.length,
//         separatorBuilder: (_, __) => const SizedBox(height: WatterSizes.spaceBtwItems),
//         itemBuilder: (_, index) {
//           final order = controller.userOrders[index];
//           return TRoundedContainer(
//             padding: const EdgeInsets.all(WatterSizes.md),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Status: ${getStatusText(order.status)}",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge!
//                         .apply(color: WatterColors.primary, fontWeightDelta: 1)),
//                 Text("Date: ${order.createdAt.toLocal().toString().split(' ')[0]}"),
//                 Text("Order ID: ${order.id}"),
//                 Text("Items: ${order.items.length}"),
//                 Text("Total: ₹${order.totalAmount.toStringAsFixed(2)}"),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: IconButton(
//                     icon: const Icon(Iconsax.arrow_right_34),
//                     onPressed: () {
//                       Get.to(() => OrderDetailsPage(order: order));
//                     },
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       );
//     });
//   }
//
//   String getStatusText(int status) {
//     switch (status) {
//       case 0: return "Placed";
//       case 1: return "In Progress";
//       case 2: return "Out for Delivery";
//       case 3: return "Delivered";
//       default: return "Unknown";
//     }
//   }
// }

