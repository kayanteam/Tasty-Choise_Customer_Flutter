import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/services/notification_service.dart';
import 'package:tasty_choise_customer/future/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/my_body.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/my_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getHomeData();
    OrderCubit.get(context).getOrder();
    NotificationCubit.get(context).getNotification();

    AuthCubit.get(context).loadDataUser();

    NotificationService.init();
    NotificationService.requestIOSPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        if (notification.title != null) {
          NotificationService.showNotification(
            id: notification.hashCode,
            title: notification.title ?? "",
            body: notification.body ?? "",
            urlImage: notification.android == null
                ? null
                : notification.android!.imageUrl,
          );
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyBody(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
