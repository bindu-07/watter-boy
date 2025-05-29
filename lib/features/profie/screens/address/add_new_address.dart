import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:water_boy/common/widgets/appbar.dart';
import 'package:water_boy/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Add New Address',style: Theme.of(context).textTheme.headlineSmall,),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(WatterSizes.defaultSpace),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Reciver\'s Name'),),
              SizedBox(height: WatterSizes.spaceBtwInputFields,),
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Reciver\'s Number'),),
              SizedBox(height: WatterSizes.spaceBtwInputFields,),
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'House / FLATE'),),
              SizedBox(height: WatterSizes.spaceBtwInputFields,),
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Floor (optional)'),),
              SizedBox(height: WatterSizes.spaceBtwInputFields,),
              TextFormField(
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Landmark (optional)'),),
              SizedBox(height: WatterSizes.spaceBtwInputFields,),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('Save')),),

            ],
          )),
        ),
      ),
    );
  }
}
