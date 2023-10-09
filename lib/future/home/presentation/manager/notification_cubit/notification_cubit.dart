import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/future/home/domin/notification_repo.dart';
import 'package:tasty_choise_customer/future/home/models/notification/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repo) : super(NotificationInitial());

  final NotificationRepo repo;

  static NotificationCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<NotificationModel> notification = [];

  Future getNotification() async {
    emit(NotificationLoading());
    (await repo.notification()).fold(
      (l) {
        emit(NotificationFailuer(l));
      },
      (r) {
        notification.clear();
        r.data.forEach((v) {
          notification.add(NotificationModel.fromJson(v));
        });
        emit(NotificationSuccess());
      },
    );
  }
}
