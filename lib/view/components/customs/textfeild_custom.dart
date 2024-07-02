import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool readOnly;
  final String? labelName;
  final String? labelText;
  final Widget? suffixIcon;
  final String? hintText;
  final EdgeInsets? padding;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final BorderSide? errorBorderSide;
  final BorderSide? focusedErrorBorderSide;
  final double? contentPadding;
  final Color? fillColor;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final String obscuringCharacter;

  const
  CustomTextField(
      {super.key,
      this.maxLines = 1,
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.onTap,
      this.labelName,
      this.readOnly = false,
      this.validator,
      this.autoValidateMode,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.maxLength,
      this.padding,
      this.labelText,
      this.borderSide,
      this.contentPadding,
      this.fillColor,
      this.floatingLabelBehavior,
      this.errorBorderSide,
      this.onChanged,
      this.focusedBorderSide,
      this.focusedErrorBorderSide,
      this.labelStyle,
        this.obscuringCharacter = '•',
      this.inputFormatters, this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelName != null) ...[
            TextCustom(
              text: labelName!,
              color: AppColors.grey,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(6),
            ),
          ],
          TextFormField(
            inputFormatters: inputFormatters,
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onTap: onTap,
            onChanged: onChanged,
            obscureText: obscureText,
            validator: validator,
            readOnly: readOnly,
            autovalidateMode: autoValidateMode,
            cursorColor: AppColors.lavender,
            obscuringCharacter:obscuringCharacter,
            decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: contentPadding ?? 20, vertical: 15),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                hintText: hintText,
                hintStyle: hintStyle ?? TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: ScreenUtil().setSp(12.5),
                  fontFamily: "Poppins",
                ),
                labelText: labelText,
                alignLabelWithHint: false,
                labelStyle: labelStyle ??
                    TextStyle(
                      fontSize: ScreenUtil().setSp(14.2.sp),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontFamily: "Poppins",
                    ),
                fillColor: fillColor ?? const Color(0xffEEECEC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: borderSide ?? BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: focusedBorderSide ?? BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: borderSide ?? BorderSide.none),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: errorBorderSide ?? BorderSide.none),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: focusedErrorBorderSide ?? BorderSide.none),
                floatingLabelBehavior: floatingLabelBehavior,
                floatingLabelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(14.2.sp),
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontFamily: "Poppins",
                )),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(12.5),
              fontWeight: FontWeight.bold,
              color: AppColors.slateGray,
              fontFamily: "Poppins",
            ),
            maxLines: maxLines,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
