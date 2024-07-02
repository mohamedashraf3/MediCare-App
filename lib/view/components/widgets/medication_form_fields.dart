import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medicare/view/components/widgets/time_dosage_widget.dart';
import '../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../../view_model/utils/radio_alert_function.dart';
import '../customs/button_custom.dart';
import '../customs/text_custom.dart';
import '../customs/textfeild_custom.dart';
import 'number_of_days_alert/days_number_alert_widget.dart';

class MedicationFormFields extends StatelessWidget {
  const MedicationFormFields(
      {super.key,
      this.isSizedBox = true,
      this.addAdditionalMedication,
      required this.ButtonOnPressed});

  final Widget? addAdditionalMedication;
  final void Function() ButtonOnPressed;
  final bool isSizedBox;

  @override
  Widget build(BuildContext context) {
    HealthFormCubit cubit = HealthFormCubit.get(context);
    return BlocConsumer<HealthFormCubit, HealthFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: cubit.medicationDetailsFormKey,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(10.h),
                  ),
                  TextCustom(
                    text: "Add Your Medications",
                    fontWeight: FontWeight.bold,
                    fontSize: 18.5,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(27.5.h),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9 ]')),
                      LengthLimitingTextInputFormatter(20),
                    ],
                    errorBorderSide: BorderSide(color: Colors.red, width: .8.w),
                    focusedErrorBorderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    controller: cubit.medicationNameController,
                    labelText: "Medication Name",
                    hintText: "Enter Medication Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: AppColors.white,
                    focusedBorderSide:
                        BorderSide(color: AppColors.lavender, width: .8.w),
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(25.h),
                  ),
                  CustomTextField(
                    hintText: "Select Medication Form",
                    errorBorderSide: BorderSide(color: Colors.red, width: .8.w),
                    focusedErrorBorderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    controller: cubit.medFormController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    labelText: "Medication Form",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: AppColors.white,
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    focusedBorderSide:
                        BorderSide(color: AppColors.lavender, width: .8.w),
                    onTap: () async {
                      await RadioAlertFunction<String>(
                        options: cubit.medicationForm,
                        initialValue: cubit.medicationFormSelected,
                        onSelected: (value) {
                          cubit.selectMedForm(value!);
                          cubit.medFormController.text = value;
                          Navigator.of(context).pop();
                        },
                      ).show(context, 'Select Medication Form');
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 22.sp,
                    ),
                    readOnly: true,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(25.h),
                  ),
                  CustomTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    errorBorderSide: BorderSide(color: Colors.red, width: .8.w),
                    focusedErrorBorderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    hintText: "Select Frequency",
                    controller: cubit.frequencyController,
                    labelText: "Frequency",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: AppColors.white,
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    focusedBorderSide:
                        BorderSide(color: AppColors.lavender, width: .8.w),
                    onTap: () async {
                      await RadioAlertFunction<String>(
                        options: cubit.frequency,
                        initialValue: cubit.frequencySelected,
                        onSelected: (value) async {
                          cubit.selectFrequency(value!);
                          cubit.frequencyController.text = value;
                          Navigator.of(context).pop();
                          if (value == "Every [Number] Hours") {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertWidget(
                                cubit: cubit,
                                formKey: cubit.everyHourFormKey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                item1: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextCustom(
                                        text: "Remind me every",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextField(
                                        hintText: "Enter Hours",
                                        errorBorderSide: BorderSide(
                                          color: Colors.red,
                                          width: .8.w,
                                        ),
                                        focusedErrorBorderSide: BorderSide(),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        borderSide: BorderSide(
                                          color: AppColors.lightGrey,
                                          width: .8.w,
                                        ),
                                        focusedBorderSide: BorderSide(
                                          color: AppColors.lavender,
                                          width: .8.w,
                                        ),
                                        controller: cubit.remindEveryController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                item2: SizedBox(
                                  height: ScreenUtil().setHeight(10.h),
                                ),
                                item3: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextCustom(
                                        text: "Start Hour",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextField(
                                        focusedErrorBorderSide: BorderSide(
                                          color: AppColors.lightGrey,
                                          width: .8.w,
                                        ),
                                        focusedBorderSide: BorderSide(
                                          color: AppColors.lavender,
                                          width: .8.w,
                                        ),
                                        borderSide: BorderSide(
                                          color: AppColors.lightGrey,
                                          width: .8.w,
                                        ),
                                        controller: cubit.startHourController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        readOnly: true,
                                        hintText: "8:00",
                                        onTap: () async {
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            cubit.startHourController.text =
                                                value!.format(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  if (cubit.everyHourFormKey.currentState!
                                      .validate()) {
                                    cubit.everyHourFormKey.currentState!.save();
                                    Navigator.pop(context);
                                    cubit.frequencyController.text = "Every " +
                                        cubit.remindEveryController.text +
                                        " Hours";
                                  }
                                },
                              ),
                            ).then((value) {
                              if (cubit.startHourController.text.isEmpty &&
                                  cubit.remindEveryController.text.isEmpty) {
                                cubit.frequencyController.text = "";
                              }
                            });
                          }
                          if (value == "Specific Days of the Week") {
                            cubit.showMultiSelectModal(
                              context,
                              items: cubit.days,
                              selectedItems: cubit.days
                                  .where((day) =>
                                      cubit.daySelected?.contains(day) ?? false)
                                  .toList(),
                              onConfirm: (selectedDays) {
                                cubit.daySelected = selectedDays.join(", ");
                                if (cubit.frequencySelected ==
                                    "Specific Days of the Week") {
                                  cubit.frequencyController.text =
                                      cubit.daySelected!;
                                }
                                cubit.emit(SelectDayState());
                              },
                            ).then((selectedDays) {
                              if (cubit.daySelected != null) {
                                cubit.frequencyController.text =
                                    cubit.daySelected!;
                              } else {
                                cubit.frequencyController.text = "";
                              }
                            });
                          }
                        },
                      ).show(context, 'Select Frequency');
                    },
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 22.sp,
                    ),
                    readOnly: true,
                  ),
                  if (cubit.frequencySelected != "Every [Number] Hours") ...[
                    SizedBox(
                      height: ScreenUtil().setHeight(25.h),
                    ),
                    TimeAndDosageWidget(
                      cubit: cubit,
                      iconButton: IconButton(
                          onPressed: () {
                            cubit.addAdditionalRow();
                          },
                          icon: Icon(
                            Icons.add_circle_outlined,
                            color: AppColors.lavender,
                            size: 26.sp,
                          )),
                      dosageController: cubit.dosageController,
                      timeController: cubit.timeController,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.additionalRowsCount,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(15.h),
                            ),
                            TimeAndDosageWidget(
                              cubit: cubit,
                              iconButton: IconButton(
                                  onPressed: () {
                                    cubit.removeAdditionalRow(index);
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outlined,
                                    color: AppColors.lavender,
                                    size: 26.sp,
                                  )),
                              dosageController: cubit.dosageControllers[index],
                              timeController: cubit.timeControllers[index],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                  SizedBox(
                    height: ScreenUtil().setHeight(25.h),
                  ),
                  CustomTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    errorBorderSide: BorderSide(color: Colors.red, width: .8.w),
                    focusedErrorBorderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    labelText: "Start Day",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: AppColors.white,
                    keyboardType: TextInputType.number,
                    hintText: "pick start day",
                    controller: cubit.startDayController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    focusedBorderSide:
                        BorderSide(color: AppColors.lavender, width: .8.w),
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 1)),
                        lastDate: DateTime(2050),
                      ).then((value) {
                        if (value != null) {
                          cubit.startDayController.text =
                              DateFormat('yyyy-MM-dd').format(value);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(25.h),
                  ),
                  CustomTextField(
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      hintText: "select duration",
                      errorBorderSide:
                          BorderSide(color: Colors.red, width: .8.w),
                      focusedErrorBorderSide:
                          BorderSide(color: AppColors.lightGrey, width: .8.w),
                      labelText: "Duration",
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 22.sp,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: AppColors.white,
                      readOnly: true,
                      controller: cubit.durationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      borderSide:
                          BorderSide(color: AppColors.lightGrey, width: .8.w),
                      focusedBorderSide:
                          BorderSide(color: AppColors.lavender, width: .8.w),
                      onTap: () async {
                        await RadioAlertFunction<String>(
                          options: cubit.duration,
                          initialValue: cubit.durationSelected,
                          onSelected: (value) {
                            cubit.selectDuration(value!);
                            Navigator.of(context).pop();
                            cubit.durationController.text = value;
                            if (value == "Number of days") {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertWidget(
                                      cubit: cubit,
                                      formKey: cubit.daysNumberFormKey,
                                      item1: TextCustom(
                                        text:
                                            "for how many days will you be take this medication ?",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      item2: SizedBox(
                                        height: ScreenUtil().setHeight(15.h),
                                      ),
                                      item3: Center(
                                        child: CustomTextField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          errorBorderSide: BorderSide(
                                              color: Colors.red, width: .8.w),
                                          focusedErrorBorderSide: BorderSide(
                                              color: AppColors.lightGrey,
                                              width: .8.w),
                                          labelText: "Number of days",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 16.sp,
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          fillColor: AppColors.white,
                                          controller: cubit.numberController,
                                          keyboardType: TextInputType.number,
                                          borderSide: BorderSide(
                                              color: AppColors.lightGrey,
                                              width: .8.w),
                                          focusedBorderSide: BorderSide(
                                              color: AppColors.lavender,
                                              width: .8.w),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Required";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        if (cubit
                                            .daysNumberFormKey.currentState!
                                            .validate()) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    );
                                  }).then((value) {
                                if (cubit.numberController.text.isNotEmpty) {
                                  cubit.durationController.text =
                                      " (${cubit.numberController.text} days)";
                                } else {
                                  cubit.durationController.clear();
                                }
                              });
                            }
                          },
                        ).show(context, 'Select Duration');
                      }),
                  SizedBox(
                    height: ScreenUtil().setHeight(25.h),
                  ),
                  addAdditionalMedication ??
                      Center(
                          child: InkWell(
                        onTap: () {
                          if (cubit.medicationDetailsFormKey.currentState!
                                  .validate() ==
                              false) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertWidget(
                                      cubit: cubit,
                                      buttonText: "Ok",
                                      item1: Row(
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 28.sp,
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          TextCustom(
                                            text: "Please fill all the details",
                                            fontWeight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ));
                          }
                          cubit.addAnotherMedication();
                        },
                        child: TextCustom(
                          text: "Add another medication",
                          color: AppColors.lavender,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      )),
                  if (isSizedBox == true)
                    SizedBox(
                      height: ScreenUtil().setHeight(18.h),
                    ),
                  ButtonCustom(
                    width: double.infinity,
                    onPressed: ButtonOnPressed,
                    child: TextCustom(
                      text: "Done",
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (isSizedBox == false)
                    SizedBox(
                      height: ScreenUtil().setHeight(18.h),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
