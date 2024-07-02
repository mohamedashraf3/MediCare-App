import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/screens/auth/forget_password/forget_password_screen.dart';
import 'package:medicare/view/screens/auth/login/login_screen.dart';
import 'package:medicare/view/screens/auth/sign_up/sign_up_screen.dart';
import 'package:medicare/view/screens/doctors/doctors.dart';
import 'package:medicare/view/screens/health_follow-up/health_condition/health%20_condition_screen.dart';
import 'package:medicare/view/screens/health_follow-up/medication_details/medication_details_screen.dart';
import 'package:medicare/view/screens/home/home.dart';
import 'package:medicare/view/screens/notifications/notifications.dart';
import 'package:medicare/view/screens/onboarding/onbording.dart';
import 'package:medicare/view/screens/pharmacy/pharmacy_screen.dart';
import 'package:medicare/view/screens/select_payment/select_payment_screen.dart';
import 'package:medicare/view/screens/shopping_cart/shopping_cart.dart';
import 'package:medicare/view/screens/splash/splash.dart';
import 'package:medicare/view_model/bloc/app/app_cubit.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/bloc/doctor/doctor_cubit.dart';
import 'package:medicare/view_model/bloc/health_follow-up/health_form_cubit.dart';
import 'package:medicare/view_model/bloc/pharmacy/pharmacy_cubit.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_keys.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_prefrence.dart';
import 'package:medicare/view_model/data/network/dio_helper.dart';
import 'package:medicare/view_model/utils/routes.dart';
import 'package:medicare/view_model/utils/show_notification.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Initialize other services
    await DioHelper.init();
    await LocalData.init();
    await ScreenUtil.ensureScreenSize();
    await AlarmService.initialize();
  } catch (e) {
    print('Failed to initialize Firebase or other services: $e');
    return;
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthCubit()),
      BlocProvider(create: (context) => HealthFormCubit()),
      BlocProvider(create: (context) => AppCubit()),
      BlocProvider(create: (context) => DoctorCubit()..getDoctors()),
      BlocProvider(create: (context) => PharmacyCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isFirstTime = LocalData.get(SharedKeys.isFirstTime) ?? true;
    AppCubit.get(context).requestPermission();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp(
          routes: {
            NamedRoutes.onboarding: (context) => OnboardingScreen(),
            NamedRoutes.splash: (context) => SplashScreen(),
            NamedRoutes.login: (context) => LoginScreen(),
            NamedRoutes.signup: (context) => SignUpScreen(),
            NamedRoutes.home: (context) => HomeScreen(),
            NamedRoutes.notifications: (context) => const NotificationsScreen(),
            NamedRoutes.healthCondition: (context) =>
                const HealthConditionScreen(),
            NamedRoutes.medicationDetails: (context) =>
                const MedicationDetailsScreen(),
            NamedRoutes.forgetPassword: (context) =>
                const ForgetPasswordScreen(),
            NamedRoutes.doctors: (context) => const DoctorsScreen(),
            NamedRoutes.pharmacy: (context) => const PharmacyScreen(),
            NamedRoutes.selectPayment: (context) => const SelectPaymentScreen(),
            NamedRoutes.shoppingCart: (context) => const ShoppingCartScreen(),
          },
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) => SplashScreen());
          },
          builder: (context, child) {
            ScreenUtil.init(context);
            return child!;
          },

          debugShowCheckedModeBanner: false,
          title: "MediCare App",
          initialRoute: isFirstTime ? NamedRoutes.onboarding : NamedRoutes.home,
        );
      },
    );
  }
}
