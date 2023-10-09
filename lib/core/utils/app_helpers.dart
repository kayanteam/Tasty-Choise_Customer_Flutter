import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/services/navigation_service.dart';
import 'package:tasty_choise_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/locator.dart';

class AppHelpers {
  static Map<String, String> getHeader() {
    if (SharedPrefController().getToken != null) {
      return {
        "Accept": "application/json",
        'Authorization': 'Bearer ${SharedPrefController().getToken}',
        // 'lang': SharedPrefController().getLang
        'lang': SharedPrefController().getLang
      };
    } else {
      return {
        "Accept": "application/json",
        'lang': SharedPrefController().getLang
      };
    }
  }

  static void navigationReplacementToPage(BuildContext context, Widget screen) {
    locator<NavigationService>().nav.pushReplacement(
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
  }

  static void navigationToPageAndExitAll(BuildContext context, Widget screen) {
    locator<NavigationService>().nav.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }

  static void navigationToPageAndExitAllWithoutFirst(BuildContext context) {
    locator<NavigationService>().nav.popUntil((route) => route.isFirst);
  }

  static Future navigationToPage(BuildContext context, Widget screen) {
    return locator<NavigationService>().nav.push(
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
  }

  static void navigationBack(BuildContext context) {
    locator<NavigationService>().nav.pop(context);
  }

  static showSnackBar(
    BuildContext context, {
    required String message,
    Color? textColor,
    Color? background,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MyText(
          title: message,
          fontSize: 14,
          color: textColor ?? AppColors.WHITE,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: error
            ? const Color.fromARGB(255, 132, 33, 13)
            : const Color.fromARGB(255, 16, 98, 16),
      ),
    );
  }

  static String? checkFillData(String? s, BuildContext context) {
    if (s == null || s.isEmpty) {
      return 'الرجاء املئ الحقل اعلاه';
    }

    return null;
  }

  static String? checkFillDataWithMatchPaawords(
      String? s, String? s1, BuildContext context) {
    if (s == null || s.isEmpty) {
      return 'الرجاء املئ الحقل اعلاه';
    }

    if (s != s1) {
      return 'الرجاء من تشابه كلمتا السر';
    }

    return null;
  }

  static Future<String?> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return "${selectedDate.toLocal()}".split(' ')[0];
    }
    return null;
  }
}
