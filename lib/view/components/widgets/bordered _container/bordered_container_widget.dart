import 'package:flutter/material.dart';

import '../../../../view_model/utils/app_colors.dart';
class BorderedContainerWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const BorderedContainerWidget({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap:onTap ,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.lightGrey,
            width: 1.5,
          ),
        ),
        child:child,
      ),
    );
  }
}
