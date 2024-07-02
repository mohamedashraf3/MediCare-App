import 'package:flutter/material.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/widgets/bordered%20_container/bordered_container_widget.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

import '../../../../view_model/utils/images.dart';

class ThirdPartyAuthWidget extends StatelessWidget {
  final String operation;
  final String footerText;
  final String footerButtonText;
  final VoidCallback onFooterButtonPressed;
  final VoidCallback onFaceTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const ThirdPartyAuthWidget({
    required this.operation,
    required this.onFooterButtonPressed,
    super.key,
    required this.footerText,
    required this.footerButtonText, required this.onFaceTap, required this.onGoogleTap, required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //  Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Flexible(
        //       child: Divider(
        //         color: AppColors.lightGrey,
        //         thickness: 1,
        //         endIndent: 15,
        //       ),
        //     ),
        //     TextCustom(
        //       text: "Or $operation with",
        //       color: AppColors.darkGrey,
        //       fontSize: 14,
        //       fontWeight: FontWeight.w600,
        //     ),
        //     const Flexible(
        //       child: Divider(
        //         color: AppColors.lightGrey,
        //         thickness: 1,
        //         indent: 15,
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     BorderedContainerWidget(
        //       onTap: onFaceTap,
        //       child: Image.asset(
        //         Images.facebook,
        //         width: 40,
        //         height: 40,
        //         color: AppColors.blueAccent,
        //         filterQuality: FilterQuality.high,
        //       ),
        //
        //     ),
        //     SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        //     BorderedContainerWidget(
        //        onTap: onGoogleTap,
        //       child: Image.asset(
        //         Images.google,
        //         width: 40,
        //         height: 40,
        //       ),
        //     ),
        //     SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        //     BorderedContainerWidget(
        //       onTap: onAppleTap ,
        //       child: Image.asset(
        //         Images.apple,
        //         width: 35,
        //         height: 40,
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextCustom(
              text: footerText,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            InkWell(
              onTap: onFooterButtonPressed,
              child: TextCustom(
                text: footerButtonText,
                color: AppColors.lavender,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
