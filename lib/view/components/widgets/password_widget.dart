import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/bloc/auth/auth_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../customs/textfeild_custom.dart';
class PasswordWidget extends StatelessWidget {
  final AuthCubit cubit;
  const PasswordWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return  CustomTextField(
      labelName: "Password",
      controller: cubit.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: cubit.passwordVisible,
      textInputAction: TextInputAction.done,
      onTap: () {
        cubit.passwordError = null;
      },
      suffixIcon: IconButton(
        icon: cubit.passwordVisible
            ?  Icon(
          Icons.visibility_off,
          color: AppColors.darkGrey,
          size:18.h,
        )
            :  Icon(
          Icons.remove_red_eye,
          color: AppColors.darkGrey,
          size:18.h,
        ),
        onPressed: () {
          cubit.changePasswordVisibility();
        },
      ),
      
      hintText: "must be 8 characters",
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.length < 8) {
          return "Password must be at least 8 characters";
        } else if (value.isEmpty) {
          return "Password can't be empty";
        }else if(cubit.passwordError != null){
          return cubit.passwordError;
        }
        return null;
      },
    );
  }
}
