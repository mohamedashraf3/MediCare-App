import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/model/chat_model.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view_model/bloc/doctor/doctor_cubit.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_keys.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_prefrence.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.DrName, required this.DrID,});
  final String DrName;
  final int DrID;

  @override
  Widget build(BuildContext context) {
    var cubit = DoctorCubit.get(context);
    int userId = LocalData.get(SharedKeys.userId) ?? 0;

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        cubit.fetchMessages(userId, DrID);
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            title: Row(
              children: [
                Flexible(
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.lightGrey.withOpacity(0.5),
                    child: Icon(
                      Icons.person,
                      size: 30.r,
                      color: AppColors.lavender,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextCustom(
                    text: DrName,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.info_outlined,
                    color: AppColors.lavender,
                    size: 25.sp,
                  )),
            ],
          ),
          body: StreamBuilder<List<ChatModel>>(
              stream: cubit.messageStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ChatModel> chatList = snapshot.data!;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: cubit.controller,
                          itemCount: chatList.length,
                          itemBuilder: (context, index) {
                            final message = chatList[index];
                            return message.userId == userId
                                ? BubbleSpecialOne(
                                    text: message.message,
                                    color: AppColors.lavender,
                                    textStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      color: AppColors.white,
                                    ),
                                  )
                                : BubbleSpecialTwo(
                                    text: message.message.toString(),
                                    isSender: false,
                                    color: AppColors.grey,
                                    textStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      color: AppColors.white,
                                    ),
                                  );
                          },
                        ),
                      ),
                      MessageBar(
                        onSend: (value) {
                          cubit.sendMessage(
                              senderName: "User Name",
                              receiverName: DrName,
                              message: value,
                              senderId: userId,
                              receiverId: DrID).then((value) {
                                cubit.fetchConversations(userId);
                              });
                        },
                        sendButtonColor:
                            Theme.of(context).colorScheme.secondary,
                        actions: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.photo_library_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25.sp,
                              ),
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 16.w,
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.mic_rounded,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25.sp,
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
  }
}
