import 'package:flutter/material.dart';
import 'package:medicare/view/components/widgets/medication_form_fields.dart';


import '../../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/routes.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HealthFormCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body:MedicationFormFields(
        ButtonOnPressed:  () {
          if (cubit.medicationDetailsFormKey.currentState!
              .validate()) {
            cubit.storeMedicationData();
            cubit.medicationDetailsFormKey.currentState!.validate();
            Navigator.pushNamedAndRemoveUntil(
                context, NamedRoutes.home, (route) => false);
          }
        },

      ),
    );
  }
}
