import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({
    super.key,
    required this.text,
    this.decorationColor,
    this.fontWeight,
    this.color,
    this.fontSize = 14,
    this.decoration,
    this.height,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.fontStyle,
    this.padding,
  });

  final String text;
  final double? height;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? decorationColor;
  final double? fontSize;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding ?? const EdgeInsets.all(0),
      child: Text(
        textAlign: textAlign,
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
            fontWeight: fontWeight,
            color: color,
            fontSize: ScreenUtil().setSp(fontSize!),
            decoration: decoration,
            decorationColor: decorationColor,
            fontFamily: "Poppins",
            height: height,
            fontStyle: fontStyle),
      ),
    );
  }
}
