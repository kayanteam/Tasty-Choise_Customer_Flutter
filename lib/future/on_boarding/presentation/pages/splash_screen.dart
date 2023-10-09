import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/main_screen.dart';
import 'package:tasty_choise_customer/future/on_boarding/presentation/pages/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (SharedPrefController().getToken != null) {
        AppHelpers.navigationReplacementToPage(context, const MainScreen());
      } else {
        AppHelpers.navigationReplacementToPage(
            context, const OnBoardingScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/ic_logo.png',
          width: 260.r,
        ),
      ),
    );
  }
}
