import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/appbar_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/widgets/bottom_navigator_widget.dart';
import 'package:medicare/view/components/widgets/medication_details_card/medication_details_card.dart';
import 'package:medicare/view/components/widgets/pharmacy_doctor_widget.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:medicare/view_model/utils/images.dart';
import '../../../view_model/bloc/app/app_cubit.dart';
import '../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../view_model/utils/routes.dart';
import '../../components/customs/Drawer_custom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HealthFormCubit.get(context);
    cubit.MedicationManager();

    return BlocConsumer<HealthFormCubit, HealthFormState>(
      builder: (context, state) {
        cubit.MedicationManager();

        var nearestMedication = cubit.findNearestMedication(
            cubit.returnStoredMedication ?? [], context);

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBarCustom(),
          drawer: DrawerCustom(),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtil().setHeight(8)),
                TextCustom(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18),
                      vertical: ScreenUtil().setHeight(8)),
                  text: "Hi userName! How are you today?",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                nearestMedication.isNotEmpty
                    ? TextCustom(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18)),
                  text:
                  "Upcoming medication in ${nearestMedication['remainingTime']}",
                  fontSize: 12,
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                )
                    : SizedBox(),
                SizedBox(height: ScreenUtil().setHeight(8)),
                nearestMedication.isNotEmpty
                    ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(18),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(100),
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Image.asset(Images.capsule),
                            SizedBox(width: ScreenUtil().setWidth(15)),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                    text: nearestMedication['medName'],
                                    fontSize: 16,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                      height: ScreenUtil().setHeight(10)),
                                  TextCustom(
                                    text:
                                    "Take ${nearestMedication['dose']} ",
                                    fontSize: 12,
                                    color: AppColors.lightGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                      height: ScreenUtil().setHeight(10)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: AppColors.lightGrey,
                                        size: 15.sp,
                                      ),
                                      SizedBox(
                                          width:
                                          ScreenUtil().setWidth(10)),
                                      TextCustom(
                                        text:
                                        nearestMedication['medTime'],
                                        fontSize: 12,
                                        color: AppColors.lightGrey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: ScreenUtil().setWidth(20),
                        top: ScreenUtil().setHeight(80),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_outlined,
                              color: AppColors.lavender,
                              size: 20.sp,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Center(
                    child: TextCustom(
                        text: "You don't have any upcoming medication",
                        fontSize: 14,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenUtil().setHeight(25)),
                TextCustom(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18)),
                  text: 'Today\'s medication',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: ScreenUtil().setHeight(8)),
                Container(
                  height: ScreenUtil().setHeight(120),
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18)),
                  child: cubit.returnStoredMedication?.isEmpty ?? true
                      ? Center(
                    child: TextCustom(
                        text: "No Medication Added, Add Now",
                        color: AppColors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                      : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final medication =
                      cubit.returnStoredMedication![index];
                      bool isPassed = cubit
                          .isMedicationTimePassed(medication['time']);
                      return MedicationDetailsCard(
                        medicationName: medication['medicationName'],
                        time: medication['time'],
                        dose: medication['frequency'],
                        status: !isPassed,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: ScreenUtil().setWidth(10));
                    },
                    itemCount: cubit.returnStoredMedication?.length ?? 0,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(25)),
                TextCustom(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18)),
                  text: "Online pharmacy and doctor consultations",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PharmacyDoctorWidget(
                      text: 'Doctors',
                      image: Images.doctor,
                      onTap: () async {
                        Navigator.pushNamed(context, NamedRoutes.doctors);
                      },
                    ),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        return PharmacyDoctorWidget(
                          text: 'Pharmacy',
                          image: Images.pharmacy,
                          onTap: () async {
                            AppCubit.get(context).getCurrentPosition();
                            Navigator.pushNamed(context, NamedRoutes.pharmacy);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar(),
        );
      },
      listener: (context, state) {
        if (state is StoreDoneState) {}
      },
    );
  }
}
