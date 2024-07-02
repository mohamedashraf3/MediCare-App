import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicare/view/screens/conversations/conversation.dart';
import 'package:medicare/view/screens/drawer_screens/notification_setting/notification_setting.dart';
import 'package:medicare/view/screens/profile_screens/allergies_information/allergies_information_screen.dart';
import 'package:medicare/view/screens/profile_screens/saved_pharmacies/saved_pharmacies_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../view/components/widgets/show_add_new_medication.dart';
import '../../../view/screens/drawer_screens/about_app/about__medicare.dart';
import '../../../view/screens/home/home.dart';
import '../../../view/screens/notifications/notifications.dart';
import '../../../view/screens/profile/profile.dart';
import '../../../view/screens/profile_screens/edite_health_condition/edite_health_condition.dart';
import '../../../view/screens/profile_screens/history/history_screen.dart';
import '../../utils/show_notification.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  // Navigation-related variables and methods
  List<Widget> screens = [
    HomeScreen(),
    NotificationsScreen(),
    SizedBox(),
    ConversationScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;
  int currentIndexProfile = 0;

  final List<Widget>? profileScreens = [
    SavedPharmaciesScreen(),
    EditeHealthConditionScreen(),
    AllergiesInformationScreen(),
    HistoryScreen(),
  ];

  final List<String> profileScreenTitles = [
    "Saved pharmacies",
    "Health conditions",
    "Allergies information",
    "History"
  ];

  final List<IconData> profileScreenIcons = [
    Icons.bookmark,
    FontAwesomeIcons.heartCirclePlus,
    FontAwesomeIcons.clipboardList,
    Icons.history,
  ];

  void setIndexBottomNav({required int index, required BuildContext context}) {
    currentIndex = index;
    emit(BottomNavigatorIndex());
    if (index == 2) {
      showAddNewMedicationModal(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return screens[index];
        }),
      );
    }
  }

  void setIndexProfile({required int index, required BuildContext context}) {
    currentIndexProfile = index;
    emit(ProfileIndexChanged());
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return profileScreens![index];
    }));
  }

  // Drawer-related variables and methods
  List<String> items = [
    "Notification",
    "Share App",
    "Logout",
    "About MEDICARE",
  ];

  List<Widget> DrawerScreens = [
    NotificationSetting(),
    ProfileScreen(),
    SizedBox(),
    AboutMedicare(),
  ];

  List<IconData> icons = [
    Icons.notifications_none_outlined,
    Icons.share_outlined,
    Icons.logout,
    Icons.info_outline
  ];

  // Notification-related variables and methods
  bool isDisableAllNotification = false;
  bool isNewPharmacyDoctorNotification = true;
  bool isMissedDoseNotification = false;
  bool isMedicationReminder = false;

  List<String> notificationTypes = [
    "Pop-up notification",
    "In-app notification"
  ];

  String selectedNotificationType = "Pop-up notification";

  void toggleDisableAllNotification() {
    isDisableAllNotification = !isDisableAllNotification;
    emit(SwitchChangedState());
  }

  void toggleNewPharmacyDoctorNotification() {
    isNewPharmacyDoctorNotification = !isNewPharmacyDoctorNotification;
    emit(SwitchChangedState());
  }

  void toggleMedicationReminder() {
    isMedicationReminder = !isMedicationReminder;
    emit(SwitchChangedState());
  }

  void toggleMissedDoseNotification() {
    isMissedDoseNotification = !isMissedDoseNotification;
    emit(SwitchChangedState());
  }

  void updateNotificationType({required String type}) {
    selectedNotificationType = type;
    emit(UpdateNotificationTypeState());
  }

  // Alarm-related variables and methods
  Future<void> scheduleAlarm({
    required DateTime scheduledNotificationDateTime,
    required int id,
  }) async {
    final int alarmId = id;
    try {
      await AndroidAlarmManager.oneShotAt(
        scheduledNotificationDateTime,
        alarmId,
        AlarmService.showNotification,
        alarmClock: true,
        exact: true,
        wakeup: true,
      );
      print('Alarm scheduled for: $scheduledNotificationDateTime');
      emit(AlarmScheduledSuccess());
    } catch (e) {
      print('Error scheduling alarm: $e');
      emit(AlarmScheduledError());
    }
  }

  Future<void> requestPermission() async {
    try {
      PermissionStatus alarmPermissionStatus =
          await Permission.scheduleExactAlarm.request();
      if (!alarmPermissionStatus.isGranted) {
        print('Schedule Exact Alarm permission not granted');
        emit(PermissionRequestError());
        return;
      }

      PermissionStatus notificationPermissionStatus =
          await Permission.notification.request();
      if (!notificationPermissionStatus.isGranted) {
        print('Notification permission not granted');
        emit(PermissionRequestError());
        return;
      }

      PermissionStatus notificationPolicyPermissionStatus =
          await Permission.accessNotificationPolicy.request();
      if (!notificationPolicyPermissionStatus.isGranted) {
        print('Access Notification Policy permission not granted');
        emit(PermissionRequestError());
        return;
      }

      PermissionStatus storagePermissionStatus =
          await Permission.storage.request();
      if (!storagePermissionStatus.isGranted) {
        print('Storage permission not granted');
        emit(PermissionRequestError());
        return;
      }

      emit(PermissionRequestSuccess());
    } catch (e) {
      print('Error requesting permissions: $e');
      emit(PermissionRequestError());
    }
  }

  Future<void> alarmWithPermission({
    required BuildContext context,
    required DateTime scheduledNotificationDateTime,
    required int id,
  }) async {
    emit(AlarmWithPermissionLoading());
    if (await Permission.notification.isGranted &&
        await Permission.scheduleExactAlarm.isGranted &&
        await Permission.accessNotificationPolicy.isGranted) {
      try {
        scheduleAlarm(
          scheduledNotificationDateTime: scheduledNotificationDateTime,
          id: id,
        );
        emit(AlarmWithPermissionSuccess());
      } catch (e) {
        print('Error scheduling alarm: $e');
        emit(AlarmWithPermissionError());
      }
    } else {
      print('Permission not granted');
      emit(AlarmWithPermissionError());
    }
  }

  // Location-related variables and methods
  Position? currentPosition;
  String? currentAddress;
  LocationPermission? permission;

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationServiceDisabledState());
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(LocationPermissionDeniedState());
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(LocationPermissionDeniedForeverState());
      return;
    }
    emit(LocationGrantedState());
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      emit(LocationAddressLoadingState());
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      currentAddress = '${place.locality}';
      print(currentAddress);
      emit(LocationAddressLoadedState());
    } catch (e) {
      debugPrint(e.toString());
      emit(LocationAddressErrorState());
    }
  }

  Future<void> getCurrentPosition() async {
    await checkLocationPermission();

    if (state is! LocationGrantedState) {
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentPosition = position;
      getAddressFromLatLng(currentPosition!);
      emit(CurrentPositionLoadedState());
    } catch (e) {
      debugPrint(e.toString());
      emit(CurrentPositionErrorState());
    }
  }

  // Sharing-related methods
  void shareAppLink() async {
    final appLink =
        'https://drive.google.com/file/d/1kpw64XfX_QFfnuB_dWMN9NbeGAPImBLu/view?usp=sharing';
    final result = await Share.share(
      'Make Life Easier for Your Contacts: Share Our App Today! $appLink: $appLink',
      subject: 'Download the App Now!',
    );

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the app!');
    } else {
      print('Share was not completed.');
    }
  }
}
