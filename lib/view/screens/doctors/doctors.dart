import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/widgets/doctor_list_card/doctor_list_card.dart';

import '../../../view_model/bloc/doctor/doctor_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../components/customs/search_bar_custom.dart';
import '../../components/customs/text_custom.dart';
import '../../components/widgets/bottom_navigator_widget.dart';
import '../chat/chat.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = DoctorCubit.get(context);
    return BlocProvider.value(
      value: cubit..getDoctors(),
      child: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              scrolledUnderElevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      text: "Find a doctor",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lavender,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 35.h,
                      child: CustomSearchBar(),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    TextCustom(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      text: "Suggested for you",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lavender,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    cubit.doctorList.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                var doctor = cubit.doctorList[index];
                                return DoctorListCard(
                                  name: doctor.name ?? 'No Name',
                                  specialization: doctor.specialization ??
                                      'No Specialization',
                                  address: doctor.location ?? 'No Address',
                                  rating: doctor.rate ?? 0.0,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          DrName: doctor.name ?? 'No Name',
                                          DrID: doctor.id ?? 0,
                                        ),
                                      ),
                                    );
                                  },
                                  experience:
                                      doctor.brief ?? 'No brief available',
                                );
                              },
                              itemCount: cubit.doctorList.length,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                  ]),
            ),
            bottomNavigationBar: BottomNavBar(),
          );
        },
      ),
    );
  }
}
