import 'package:flutter/cupertino.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../utils/constants/colors.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = WatterSizes.cardRadiusLg,
    this.padding,
    this.child,
    this.backgroundColor = WatterColors.white,
    this.margin,
    this.borderColor = WatterColors.borderPrimary,
    this.showBorder = false,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          color: backgroundColor),
      child: child,
    );
  }
}
