import 'package:flutter/material.dart';
import 'package:medicare/view/components/customs/text_custom.dart';

import '../../../view_model/utils/app_colors.dart';

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
  this.item, this.shape, this.onLongPress,

  });

  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Function()? onTap;
  final void Function()? onLongPress;
  final String? item;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return ListTile(
    shape: shape,
      onTap: onTap,
      onLongPress:onLongPress,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: leading,
      title: title?? TextCustom(
        text: item??"",
        fontWeight: FontWeight.bold,
        color: AppColors.black,
        fontSize:14,
      ),
      titleAlignment: ListTileTitleAlignment.center,
      trailing: trailing,
    );
  }
}
