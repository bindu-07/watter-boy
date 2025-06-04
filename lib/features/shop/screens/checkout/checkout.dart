import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/common/widgets/rounded_container.dart';
import 'package:water_boy/common/widgets/success_screen.dart';
import 'package:water_boy/features/shop/screens/cart/cart_item.dart';
import 'package:water_boy/features/shop/screens/checkout/select_delivery_boy.dart';
import 'package:water_boy/navigation_menu.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/image_string.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WatterSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*const CartItems(
                showAddRemoveButton: false,
              ),
              const SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),*/
              Text("Select a Delivery Boy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),
              DeliveryBoySelector(),
              const SizedBox(
                height: WatterSizes.spaceBtwSections,
              ),
              TRoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(WatterSizes.md),
                backgroundColor: dark ? Colors.black : Colors.white,
                child: Column(
                  children: [
                    ///pricing

                    BillingPayment(),
                    const SizedBox(
                      height: WatterSizes.spaceBtwItems,
                    ),

                    ///Devider
                    Divider(),
                    const SizedBox(
                      height: WatterSizes.spaceBtwItems,
                    ),

                    ///Payment Method
                    BillingAddressSection(),
                    const SizedBox(
                      height: WatterSizes.spaceBtwItems,
                    ),

                    ///Address
                    ShippingAddress()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(WatterSizes.defaultSpace),
        child: ElevatedButton(onPressed: ()=> Get.to(()=> SuccessScreen(
          image: WatterImages.successfulPaymentIcon,
          title: 'Payment Success',
          subTittle: 'Your Watter refile within 10 min',
          onPressed: ()=>  Get.offAll(() => const NavigationMenu()),
        )), child: Text('Continue')),
      ),
    );
  }
}

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping Address',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: WatterHelperFunction.isDarkMode(context)
                  ? Colors.white
                  : WatterColors.black),
            ),
            TextButton(onPressed: (){}, child: Text('Change'))
          ],
        ),
        SizedBox(height: WatterSizes.spaceBtwItems / 2,),
        Text(
          'Bindu hait',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: WatterSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Icon(Icons.phone,color: Colors.grey,size: 16, ),
            SizedBox(width: WatterSizes.spaceBtwItems,),
            Text(
              '+91 9330373008',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: WatterSizes.spaceBtwItems / 2 ,
        ),
        Row(
          children: [
            Icon(Icons.location_history,color: Colors.grey,size: 16, ),
            SizedBox(width: WatterSizes.spaceBtwItems,),
            Expanded(
              child: Text(
                'Singur Hooghly, india, 712223',
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WatterHelperFunction.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment Method',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: dark
                  ? Colors.white
                  : WatterColors.black),
            ),
            TextButton(onPressed: (){}, child: Text('Change'))
          ],
        ),
        SizedBox(height: WatterSizes.spaceBtwItems / 2,),
        Row(
          children: [
            TRoundedContainer(width: 60, height: 35,
            backgroundColor: dark? WatterColors.light: WatterColors.white,
              padding: EdgeInsets.all(WatterSizes.sm),
              child: Image(image: AssetImage(WatterImages.paypal), fit: BoxFit.contain,),
            ),
            SizedBox(width: WatterSizes.spaceBtwItems / 2,),
            Text('Paypale',style: Theme.of(context)
                .textTheme
                .bodyLarge)
          ],
        )
      ],
    );
  }
}

class BillingPayment extends StatelessWidget {
  const BillingPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// subTotal
        Row(
          children: [
            Expanded(
                child: Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$234',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const SizedBox(
          height: WatterSizes.spaceBtwItems / 2,
        ),

        /// Shipping Charge
        Row(
          children: [
            Expanded(
                child: Text(
              'Shipping Fee',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$24',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const SizedBox(
          height: WatterSizes.spaceBtwItems / 2,
        ),

        /// order Total
        Row(
          children: [
            Expanded(
                child: Text(
              'Order Total',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$234',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(
          height: WatterSizes.spaceBtwItems / 2,
        ),
      ],
    );
  }
}
