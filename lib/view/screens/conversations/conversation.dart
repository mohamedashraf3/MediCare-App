import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/listtile_custom.dart';
import 'package:medicare/model/chat_model.dart';
import 'package:medicare/view/screens/chat/chat.dart';
import 'package:medicare/view_model/bloc/doctor/doctor_cubit.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_keys.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_prefrence.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:medicare/view/components/customs/search_bar_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/widgets/bottom_navigator_widget.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = DoctorCubit.get(context);
    int? userId = LocalData.get(SharedKeys.userId);
    if (userId == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: TextCustom(
            text: "Chat with your doctor",
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.lavender,
          ),
        ),
        body: Center(child: Text("User ID not found")),
        bottomNavigationBar: BottomNavBar(),
      );
    }
    cubit.fetchConversations(userId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: TextCustom(
          text: "Chat with your doctor",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.lavender,
        ),
        leading: SizedBox(),
      ),
      backgroundColor: AppColors.white,
      body: FutureBuilder<List<ChatModel>>(
        future: cubit.fetchConversations(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching conversations"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No conversations found"));
          } else {
            List<ChatModel> chatList = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: BlocBuilder<DoctorCubit, DoctorState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: CustomSearchBar()),
                          SizedBox(width: 10.w),
                          IconButton(
                            onPressed: () async {
                              if (cubit.selectedChats.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Delete Selected Chats"),
                                    content: Text(
                                        "Are you sure you want to delete selected chats?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          List<String> selectedConversationIds =
                                              cubit.selectedChats
                                                  .where(
                                                      (chat) =>
                                                          chat.conversationId !=
                                                          null)
                                                  .map((chat) =>
                                                      chat.conversationId!)
                                                  .toList();
                                          await cubit.deleteSelectedChats(
                                              selectedConversationIds);
                                          Navigator.pop(context);
                                          await cubit
                                              .fetchConversations(userId);
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            icon: Icon(Icons.delete_outline, size: 28.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      ...chatList.map((chat) {
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: cubit.isChatSelected(chat)
                                  ? Colors.grey.shade300
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTileCustom(
                              onLongPress: () {
                                cubit.selectChat(chat);
                              },
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChatScreen(
                                      DrName: chat.receiverName,
                                      DrID: chat.receiverId);
                                }));
                              },
                              leading: cubit.isChatSelected(chat)
                                  ? IconButton(
                                      onPressed: () {
                                        cubit.selectChat(chat);
                                      },
                                      icon: Icon(Icons.check_box,
                                          color: AppColors.lavender,
                                          size: 24.sp),
                                    )
                                  : null,
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor:
                                        AppColors.lightGrey.withOpacity(0.5),
                                    child: Icon(Icons.person,
                                        size: 20.r, color: AppColors.lavender),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          text: chat.receiverName,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: 5.h),
                                        TextCustom(
                                          text: chat.lastMessage ?? "",
                                          fontWeight: FontWeight.bold,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.check_circle_outline,
                                  color: AppColors.dimgray, size: 24.sp),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
