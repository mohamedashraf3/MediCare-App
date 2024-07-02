import 'package:flutter/material.dart';
import 'package:medicare/view/components/widgets/medication_form_fields.dart';

import '../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../view_model/utils/app_colors.dart';

void showAddNewMedicationModal(BuildContext context) {
  showModalBottomSheet(
    useSafeArea: true,
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      var cubit = HealthFormCubit.get(context);
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: MedicationFormFields(
          isSizedBox: false,
          ButtonOnPressed: () {
            if (cubit.medicationDetailsFormKey.currentState!.validate()) {
              cubit.medicationDetailsFormKey.currentState!.validate();
              cubit.storeMedicationData();
              Navigator.pop(context);
              cubit.clearControllers();
            }
          },
          addAdditionalMedication: SizedBox(),
        ),
      );
    },
  );
}
