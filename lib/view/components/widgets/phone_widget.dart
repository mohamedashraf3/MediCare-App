import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
class PhoneWidget extends StatelessWidget {
  final AuthCubit cubit;
  const PhoneWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustom(text: "Phone Number", color: AppColors.grey,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: ScreenUtil().setHeight(6)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: cubit.countryController,
                  readOnly: true,
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (Country country) {
                        cubit.countryController.text =
                        "+${country.phoneCode}";
                      },
                    );
                  },
                  hintText: "+20",
                  textInputAction: TextInputAction.next,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "select it";
                    }
                    return null;
                  },
                )),
            const SizedBox(width: 8),
            Expanded(
              flex: 7,
              child: CustomTextField(
                onTap: () {
                  cubit.phoneError = null;
                },
                controller: cubit.mobilePhoneController,
                keyboardType: TextInputType.phone,
                hintText: "0123456789",
                textInputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your phone";
                  } else if (value.length < 10) {
                    return "Invalid Phone";
                  }else if (cubit.phoneError != null) {
                    return cubit.phoneError;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
