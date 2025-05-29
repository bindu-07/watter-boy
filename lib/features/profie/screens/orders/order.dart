import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/rounded_container.dart';
import 'package:water_boy/features/profie/screens/orders/order_details.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

import '../../../../common/widgets/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall,
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
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __)=>SizedBox(height: WatterSizes.spaceBtwItems,),
      itemBuilder:(_, index) => TRoundedContainer(
        showBorder: true,
        padding: EdgeInsets.all(WatterSizes.md),
        backgroundColor: dark ? WatterColors.dark : WatterColors.light,
        child: Column(
          mainAxisSize:MainAxisSize.min ,
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
                    mainAxisSize:MainAxisSize.min ,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progessing',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: WatterColors.primary, fontWeightDelta: 1),
                      ),
                      Text('30 may 2025',
                        style: Theme.of(context).textTheme. titleMedium,)
                    ],
                  ),
                ), 
                
                IconButton(onPressed: ()=> Get.to(()=> const OrderDetailsPage()), icon: Icon(Iconsax.arrow_right_34, size: WatterSizes.iconSm,))
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
                          mainAxisSize:MainAxisSize.min ,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                            ),
                            Text('[#2345]',
                              style: Theme.of(context).textTheme. titleMedium,)
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
                        Iconsax.calendar,
                      ),
                      SizedBox(
                        width: WatterSizes.spaceBtwItems / 2,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize:MainAxisSize.min ,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Shipping Date',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                            ),
                            Text('31 may 2025',
                              style: Theme.of(context).textTheme. titleMedium,)
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
      ),
    );
  }
}
