import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/app_config.dart';
import 'package:tasty_choise_customer/core/services/crashlytics_service.dart';
import 'package:tasty_choise_customer/core/services/navigation_service.dart';
import 'package:tasty_choise_customer/core/services/notification_service.dart';
import 'package:tasty_choise_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:tasty_choise_customer/firebase_options.dart';
import 'package:tasty_choise_customer/future/on_boarding/presentation/pages/splash_screen.dart';
import 'package:tasty_choise_customer/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefController().initSharedPref();
  await NotificationService().initNotification();
  CrashlyticsService.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppConfig.providers,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Saving Station',
            theme: AppConfig.themeData(),
            debugShowCheckedModeBanner: false,
            navigatorKey: locator<NavigationService>().rootNavKey,
            localizationsDelegates: AppConfig.localization(),
            supportedLocales: AppConfig.supportedLocales(),
            locale: const Locale('ar'),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
