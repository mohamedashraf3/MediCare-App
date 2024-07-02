import 'package:flutter/material.dart';
import 'package:medicare/view/components/customs/text_custom.dart';

import '../../../view_model/utils/app_colors.dart';
import 'listtile_custom.dart';

class EnableDisableNotification extends StatelessWidget {
  final  bool value;
  final String text;
 final void Function(bool)? onChanged;
const EnableDisableNotification({Key? key, required this.value,required this.onChanged, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileCustom(
      leading: TextCustom(
        text: text,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      trailing: Switch(
        activeColor: AppColors.lavender,
        value: value,
        splashRadius: 30,
        onChanged:onChanged,

      ),
    )
    ;
  }
}
