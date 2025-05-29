import 'package:flutter/cupertino.dart';
import 'package:water_boy/utils/constants/colors.dart';

class ShadowStyle {

  static final verticalProductShadow = BoxShadow(
    color: WatterColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2)
  );
  static final horizontalProductShadow = BoxShadow(
      color: WatterColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: Offset(0, 2)
  );
}