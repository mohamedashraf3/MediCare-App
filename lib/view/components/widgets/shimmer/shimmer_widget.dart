import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../view_model/utils/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: AppColors.lavender.withOpacity(0.2),
      child: child,
    );
  }
}