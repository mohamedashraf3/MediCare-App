import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view_model/bloc/app/app_cubit.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../data/local/shared_prefrence/shared_keys.dart';
import '../../data/local/shared_prefrence/shared_prefrence.dart';
import '../../data/network/dio_helper.dart';

part 'health_form_state.dart';

class HealthFormCubit extends Cubit<HealthFormState> {
  HealthFormCubit() : super(HealthFormInitial());

  static HealthFormCubit get(context) =>
      BlocProvider.of<HealthFormCubit>(context);

  // Form keys
  final GlobalKey<FormState> healthConditionFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> daysNumberFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> medicationDetailsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> everyHourFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editeHealthConditionFormKey =
  GlobalKey<FormState>();
  final GlobalKey<FormState> editeAllergyFormKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController medicationNameController =
  TextEditingController();
  final TextEditingController bloodController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController remindEveryController = TextEditingController();
  final TextEditingController startHourController = TextEditingController();
  final TextEditingController allergyController = TextEditingController();
  final TextEditingController medFormController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController startDayController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  // Selected options
  String? frequencySelected;
  String? durationSelected;
  int? dosageSelected;
  String? bloodSelected;
  String? medicationFormSelected;
  String? daySelected;
  String? selectedDiseases;
  final List<Map<String, dynamic>> medicationData = [];

  Future<void> storeMedicationData() async {
    if (medicationDetailsFormKey.currentState!.validate()) {
      // Retrieve existing stored medications
      List<Map<String, dynamic>> existingMedications =
          getStoredMedicationFromStorage() ?? [];

      // Add the new medication to the existing list
      existingMedications.add({
        "medicationName": medicationNameController.text,
        "medForm": medicationFormSelected,
        "frequency": frequencySelected,
        "frequencySelectedDays": daySelected,
        "startHour": startHourController.text,
        "remindEvery": remindEveryController.text,
        "time": timeController.text,
        "dosage": dosageController.text,
        "startDay": startDayController.text,
        "duration": durationController.text,
        "numberOfDays": numberController.text,
      });

      medicationData.clear();
      medicationData.addAll(existingMedications);
      storeMedicationDataToStorage(medicationData);
      emit(StoreDoneState());
    }
  }

  List<Map<String, dynamic>> storedMedication = [];
  List<Map<String, dynamic>>? returnStoredMedication;

  void MedicationManager() {
    returnStoredMedication = getStoredMedicationFromStorage();
    if (returnStoredMedication != null) {
      return;
    } else {}
    emit(MedicationFetchedState());
  }

  void storeMedicationDataToStorage(List<Map<String, dynamic>> value) async {
    storedMedication = value;
    String storedMedicationJson = jsonEncode(storedMedication);
    print(storedMedicationJson);
    LocalData.set(key: SharedKeys.storeMedication, value: storedMedicationJson);
  }

  List<Map<String, dynamic>>? getStoredMedicationFromStorage() {
    String? storedMedicationJson = LocalData.get(SharedKeys.storeMedication);
    if (storedMedicationJson != null) {
      try {
        return (jsonDecode(storedMedicationJson) as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } catch (e) {
        print('Error decoding JSON: $e');
        return null;
      }
    }
    return null;
  }

  String? remainTimeToMedicationTimeInMinutes;

  DateTime parseMedicationTime(String timeString) {
    final hour = int.parse(timeString.split(':')[0]);
    final minute = int.parse(timeString.split(':')[1].split(' ')[0]);
    final isAm = timeString.contains('AM');
    final dateTime = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month,
        DateTime
            .now()
            .day, hour % 12 + (isAm ? 0 : 12), minute);
    return dateTime;
  }

  String calculateRemainingTime(DateTime nearestTime) {
    DateTime now = DateTime.now();
    Duration difference = nearestTime.difference(now);
    int minutesDifference = difference.inMinutes;

    return minutesDifference > 0 ? "$minutesDifference min" : "Now";
  }

  Map<String, dynamic> findNearestMedication(
      List<Map<String, dynamic>> medications, BuildContext context) {
    DateTime now = DateTime.now();
    DateTime? nearestTime;
    Map<String, dynamic>? nearestMedication;

    for (var medication in medications) {
      DateTime medTime = parseMedicationTime(medication['time']);
      if (medTime.isAfter(now) &&
          (nearestTime == null || medTime.isBefore(nearestTime))) {
        nearestTime = medTime;
        nearestMedication = medication;
      }
    }

    emit(NearestMedicationFoundState());

    if (nearestMedication != null) {
      String remainingTime = calculateRemainingTime(nearestTime!);
      remainTimeToMedicationTimeInMinutes = remainingTime;

      AppCubit.get(context).alarmWithPermission(
          context: context, scheduledNotificationDateTime: nearestTime, id: 0);

      LocalData.set(
          key: SharedKeys.notificationNameMedication,
          value: nearestMedication['medicationName']);

      return {
        'medName': nearestMedication['medicationName'],
        'dose':
        '${nearestMedication['dosage']} ${nearestMedication['frequency']}',
        'medTime': nearestMedication['time'],
        'remainingTime': remainingTime,
      };
    } else {
      emit(NearestMedicationNotFoundState());
      remainTimeToMedicationTimeInMinutes = null;
      return {};
    }
  }

  bool isMedicationTimePassed(String time) {
    DateTime now = DateTime.now();
    DateTime medTime = parseMedicationTime(time);
    return medTime.isBefore(now);
  }

  void deleteMedication(int index) {
    medicationData.removeAt(index);
    storeMedicationDataToStorage(medicationData);
    emit(DeleteDoneState());
  }

  void clearControllers() {
    medicationNameController.clear();
    medFormController.clear();
    frequencyController.clear();
    startHourController.clear();
    remindEveryController.clear();
    timeController.clear();
    dosageController.clear();
    startDayController.clear();
    durationController.clear();
    numberController.clear();
    emit(ClearDoneState());
  }

  void addAnotherMedication() {
    storeMedicationData().then((value) {
      clearControllers();
    });
    emit(AddAnotherMedicationState());
  }

  final List<String> diseases = [
    "Alzheimer’s disease",
    "Arthritis",
    "Asthma",
    "Autism spectrum disorder (ASD)",
    "Bipolar disorder",
    "Cancer",
    "Cataracts",
    "Celiac disease",
    "Cholera",
    "Chronic kidney disease (CKD)",
    "Chronic liver disease",
    "Chronic obstructive pulmonary disease (COPD)",
    "Coronary artery disease (CAD)",
    "Crohn’s disease",
    "Dengue fever",
    "Diabetes mellitus",
    "Down syndrome",
    "Ebola virus disease",
    "Eczema",
    "Endometriosis",
    "Epilepsy",
    "Fibromyalgia",
    "Gallstones",
    "Glaucoma",
    "Gout",
    "Heart failure",
    "Hepatitis",
    "HIV/AIDS",
    "Hypertension",
    "Influenza",
    "Irritable bowel syndrome (IBS)",
    "Kidney stones",
    "Leukemia",
    "Lyme disease",
    "Lymphoma",
    "Macular degeneration",
    "Malaria",
    "Multiple sclerosis",
    "Obsessive-compulsive disorder (OCD)",
    "Osteoporosis",
    "Parkinson’s disease",
    "Peptic ulcer disease",
    "Pneumonia",
    "Psoriasis",
    "Schizophrenia",
    "Sickle cell anemia",
    "Stroke",
    "Thalassemia",
    "Tuberculosis",
    "Ulcerative colitis"
  ];

  // Lists of options
  final List<String> dosage =
  List.generate(10, (index) => (index + 1).toString());
  final List<String> days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  final List<String> medicationForm = [
    "Capsules",
    "Cream",
    "Drops",
    "Foams",
    "Gel",
    "Injectables",
    "Inhalers",
    "Liquid",
    "Lotion",
    "Lozenges",
    "Powders",
    "Sprays",
    "Suppositories",
    "Suspensions",
    "Tablets",
    "Transdermal Patches"
  ];

  final List<String> duration = ["Continuous", "Number of days"];

  final List<String> frequency = [
    "Once Daily",
    "Twice Daily",
    "Three Times Daily",
    "More than Three Times Daily",
    "As Needed",
    "Specific Days of the Week",
    "Every [Number] Hours"
  ];
  final List<String> blood = ["AB+", "AB-", "A+", "A-", "B+", "B-", "O+", "O-"];

  // Additional rows
  int additionalRowsCount = 0;
  final List<TextEditingController> dosageControllers = [];
  final List<TextEditingController> timeControllers = [];

  // Select blood type
  Future<void> selectBloodType(String bloodStatus) async {
    bloodSelected = bloodStatus;
    emit(SelectDoneState());
  }

  // Select frequency
  Future<void> selectFrequency(String frequencyStatus) async {
    frequencySelected = frequencyStatus;
    emit(SelectDoneState());
  }

  // Select medication form
  Future<void> selectMedForm(String medicationFormStatus) async {
    medicationFormSelected = medicationFormStatus;
    emit(SelectDoneState());
  }

  // Select dosage
  Future<void> selectDosage(int dosageStatus) async {
    dosageSelected = dosageStatus;
    emit(SelectDoneState());
  }

  // Select duration
  Future<void> selectDuration(String durationStatus) async {
    durationSelected = durationStatus;
    emit(SelectDoneState());
  }

  // Add additional row
  void addAdditionalRow() {
    additionalRowsCount++;
    dosageControllers.add(TextEditingController());
    timeControllers.add(TextEditingController());
    emit(SelectDoneState());
  }

  // Remove additional row
  void removeAdditionalRow(int index) {
    if (additionalRowsCount > 0 &&
        dosageControllers.isNotEmpty &&
        timeControllers.isNotEmpty) {
      additionalRowsCount--;
      dosageControllers.removeAt(index);
      timeControllers.removeAt(index);
      emit(SelectDoneState());
    }
  }

  Future<void> showMultiSelectModal(BuildContext context, {
    required List<String> items,
    required List<String> selectedItems,
    required void Function(List<String>) onConfirm,
  }) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: items.map((item) => MultiSelectItem(item, item)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: onConfirm,
          initialValue: selectedItems,
          searchable: true,
          closeSearchIcon: Icon(
            Icons.close,
            size: 20.sp,
          ),
        );
      },
    );
  }

}
