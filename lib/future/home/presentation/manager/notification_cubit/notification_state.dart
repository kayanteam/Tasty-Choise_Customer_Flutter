part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationFailuer extends NotificationState {
  final String message;
  NotificationFailuer(this.message);
}

final class NotificationSuccess extends NotificationState {}
