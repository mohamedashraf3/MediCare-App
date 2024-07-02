import 'package:flutter/material.dart';
import 'package:medicare/view_model/utils/app_colors.dart';


class ButtonCustom extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final double? insidePadding;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  const ButtonCustom(
      {super.key,
      required this.onPressed,
      this.color,
      required this.child,
      this.width,
      this.height,
      this.radius, this.insidePadding, this.padding,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10.0),
            ),
          ),
          minimumSize: WidgetStateProperty.all(Size(width ?? 50, height ?? 20)),
          backgroundColor:
              WidgetStateProperty.all(color ?? AppColors.lavender),
          padding: WidgetStateProperty.all(EdgeInsets.all(insidePadding ?? 12)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
