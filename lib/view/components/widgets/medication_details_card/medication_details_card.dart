
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/images.dart';
import '../../customs/text_custom.dart';

class MedicationDetailsCard extends StatelessWidget {
  const MedicationDetailsCard({Key? key, required this.medicationName, required this.time, required this.dose, required this.status}) : super(key: key);
  final String medicationName;
  final String time;
  final String dose;
  final bool status;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
      child: Container(
        width: ScreenUtil().setWidth(205),
        height: ScreenUtil().setHeight(120),
        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
        margin: EdgeInsets.all(ScreenUtil().setWidth(8)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: ScreenUtil().setWidth(2),
              blurRadius: ScreenUtil().setWidth(3),
              offset: Offset(
                  0, ScreenUtil().setWidth(2)), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              Images.capsule,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(35),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: medicationName,
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  TextCustom(
                    text:dose ,
                    fontSize: 11,
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: AppColors.lightGrey,
                        size: ScreenUtil().setSp(18),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(5),
                      ),
                      TextCustom(
                        text: time,
                        fontSize: 12,
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                decoration: BoxDecoration(
                  color:  AppColors.lavender,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  status ? Icons.access_time_filled_sharp : Icons.check,

                  size: 15.sp,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
