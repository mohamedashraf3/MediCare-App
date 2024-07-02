import 'package:flutter/material.dart';
import '../../view/components/customs/text_custom.dart';
import 'app_colors.dart';

class RadioAlertFunction<T> {
  final List<String> options;
  final String? initialValue;
  final void Function(String?)? onSelected;

  RadioAlertFunction({
    required this.options,
    required this.initialValue,
    required this.onSelected,
  });

  Future<void> show(BuildContext context, String title) async {
    await showDialog<String>(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: TextCustom(
            text: title,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((value) {
                return RadioListTile<String>(
                  title: TextCustom(
                    text: value,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  value: value,
                  groupValue: initialValue,
                  onChanged: onSelected,
                  activeColor: AppColors.lavender.withOpacity(.8),
                  selected: initialValue == value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
