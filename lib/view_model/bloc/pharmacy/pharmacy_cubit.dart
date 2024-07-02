import 'package:awesome_card/extra/card_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare/model/pharmacy_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../view/components/customs/text_custom.dart';
import '../../../view/components/customs/textfeild_custom.dart';
import '../../data/local/shared_prefrence/shared_keys.dart';
import '../../data/local/shared_prefrence/shared_prefrence.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/end_points.dart';
import '../../utils/app_colors.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit() : super(PharmacyInitial());

  static PharmacyCubit get(context) => BlocProvider.of<PharmacyCubit>(context);
  final GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> paymentCardFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> vodafoneCashFormKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController cardNumberController = MaskedTextController(
    mask: '0000 0000 0000 0000',
    translator: {'0': RegExp(r'[0-9]'), 'x': RegExp(r'[^0-9]')},
  );
  final TextEditingController expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController senderNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  bool showBackSide = false;
  CardType cardType = CardType.masterCard;
  String selectedMethod = "Credit /Debit card";
  List<Map<String, dynamic>> paymentMethods = [
    {
      'value': 'Credit /Debit card',
      'widget': CustomTextField(
        padding: EdgeInsets.zero,
        readOnly: true,
        contentPadding: 20.w,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(6.0),
          child:
              Image.asset("assets/images/visa.png", width: 40.w, height: 25.h),
        ),
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          color: AppColors.darkGrey,
          fontFamily: "Poppins",
        ),
        hintText: "Credit /Debit card",
        borderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
        focusedBorderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
      ),
    },
    {
      'value': 'Vodafone cash',
      'widget': CustomTextField(
        readOnly: true,
        contentPadding: 20.w,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/vodafone.png",
              width: 40.w, height: 25.h),
        ),
        fillColor: AppColors.white,
        hintText: "Vodafone cash",
        hintStyle: TextStyle(color: AppColors.darkGrey, fontFamily: "Poppins"),
        borderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
        focusedBorderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
      ),
    },
    {
      'value': 'Cash on delivery',
      'widget': CustomTextField(
        readOnly: true,
        contentPadding: 20.w,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Image.asset("assets/images/car.png", width: 40.w, height: 25.h),
        ),
        hintText: "Cash on delivery",
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          color: AppColors.darkGrey,
          fontFamily: "Poppins",
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        borderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
        focusedBorderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
      ),
    },
  ];

  Future<void> selectPayMethod(String method) async {
    selectedMethod = method;
    emit(SelectMethodSuccess());
  }

  int counter = 0;

  void incrementCounter() {
    if (counter == 3) {
      return;
    }
    counter++;
    emit(IncrementCounterSuccess());
  }

  void decrementCounter() {
    if (counter == 0) {
      return;
    }
    counter--;
    emit(DecrementCounterSuccess());
  }

  XFile? image;

  void takePhotoFromUser({required BuildContext context}) async {
    emit(TakeImageLoadingState());

    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      print("Permission granted");

      try {
        var pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          image = pickedFile;
          emit(TakeImageSuccessState());
        } else {
          emit(TakeImageErrorState());
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: TextCustom(
                  text: "Please select an image",
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // Error picking image
        print(e);
        emit(TakeImageErrorState());
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: TextCustom(
                text: "Error picking image",
                color: AppColors.red,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Permission not granted
      emit(TakeImageErrorState());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextCustom(
              text: "Storage permission is required to pick an image",
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  void showBackSideCard() {
    showBackSide = !showBackSide;
    emit(ShowBackSideCard());
  }

  void onChangeCardPayController() {
    cardNumberController;
    expiryDateController;
    holderNameController;
    cvvController;

    emit(OnChangeController());
  }

  bool isCardSaved = LocalData.get(SharedKeys.isCardSaved) ?? false;

  void saveCard() {
    if (!isCardSaved) {
      LocalData.set(key: SharedKeys.isCardSaved, value: true);
      isCardSaved = true;
      emit(CardSavedState());
    }
  }

  Map<int, bool> savedPharmacies = {};

  void savePharmacy(int index) {
    if (savedPharmacies.containsKey(index)) {
      savedPharmacies[index] = !savedPharmacies[index]!;
    } else {
      savedPharmacies[index] = true;
    }
    emit(PharmacySavedState());
  }

  List<int>? savedPharmacyIndices;

  bool isPharmacySaved(int index) {
    return savedPharmacies[index] ?? false;
  }

  void getSavedPharmacies() {
    emit(LoadingSavedPharmaciesState());
    savedPharmacyIndices = savedPharmacies.keys
        .where((index) => savedPharmacies[index] == true)
        .toList();
    emit(SavedPharmaciesLoadedState());
  }

  List<int> addToCart = [];

  void addToCartList(int index) {
    if (addToCart.contains(index)) {
      addToCart.remove(index);
      emit(AddToCartList());
      return;
    }
    addToCart.add(index);
    emit(AddToCartList());
  }
  PharmacyListModel? pharmacyListModel;
  List<PharmacyModel> pharmaciesList = [];
  List<PharmacyModel> SavedPharmaciesList = [];

  Future<void> getPharmacies() async {
    emit(LoadingPharmaciesState());
    try {
      final response = await DioHelper.get(endpoint: EndPoints.Pharmacy);
      print(response?.data);
      pharmacyListModel = PharmacyListModel.fromJson(response?.data);
      pharmaciesList = pharmacyListModel?.pharmacies ?? [];
      emit(PharmaciesLoadedState());
    } catch (error) {
      if (error is DioException) {
        print(error.response?.data.toString());
      }
      emit(PharmaciesErrorState());
    }
  }


}
