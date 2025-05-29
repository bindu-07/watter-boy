import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/sizes.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({super.key, required this.text, required this.animation,  this.showAction = false, this.actionText,  this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width *0.8),
          const SizedBox(height: WatterSizes.defaultSpace,),
          Text(text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,),
          const SizedBox(height: WatterSizes.defaultSpace,),
          showAction?
              SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                  style: OutlinedButton.styleFrom(backgroundColor: WatterColors.dark),
                  child: Text(
                    actionText!,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: WatterColors.light),
                  ),
                ),
              ) : const SizedBox()
        ],
      ),
    );
  }
}
