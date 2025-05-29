import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_boy/utils/constants/colors.dart';
import 'package:water_boy/utils/constants/sizes.dart';
import 'package:water_boy/utils/helper/helper_function.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon(
      {super.key,
      this.width,
      this.height,
      this.size = WatterSizes.lg,
      required this.icon,
      this.color,
      this.backgroundColor,
      required this.onPressed});

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor != null
              ? backgroundColor!
              : WatterHelperFunction.isDarkMode(context)
                  ? WatterColors.black.withOpacity(0.9)
                  : WatterColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(100)),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: size,
          )),
    );
  }
}
