import 'package:flutter/cupertino.dart';
import 'package:water_boy/utils/constants/sizes.dart';

import '../../utils/constants/colors.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imgUrl,
    this.applyImageRadius = true,
    this.border,
    this.fit = BoxFit.contain,
    this.padding,
    this.borderRadius = WatterSizes.md,
    this.onPressed,
    this.isNetworkImage = false,
    this.backgroundColor = WatterColors.light,
  });

  final double? width;
  final double? height;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final VoidCallback? onPressed;
  final bool isNetworkImage;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: backgroundColor,
              border: border),
          child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: Image(
              image: isNetworkImage
                  ? NetworkImage(imgUrl)
                  : AssetImage(imgUrl) as ImageProvider,
              fit: fit,
            ),
          )),
    );
  }
}
