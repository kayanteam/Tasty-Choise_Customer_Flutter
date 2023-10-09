import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/future/home/models/notification/notification_model.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_notification.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is NotificationFailuer) {
            return const Center(child: Icon(Icons.error));
          }

          List<NotificationModel> notification =
              NotificationCubit.get(context).notification;
          return notification.length == 0
              ? Center(child: MyText(title: 'لا توجد اشعارات في الوقت الحالي'))
              : ListView.builder(
                  itemCount: notification.length,
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: MediaQuery.of(context).padding.bottom + 20.h,
                  ),
                  itemBuilder: (context, index) {
                    return ItemNotification(notification: notification[index]);
                  },
                );
        },
      ),
    );
  }
}
