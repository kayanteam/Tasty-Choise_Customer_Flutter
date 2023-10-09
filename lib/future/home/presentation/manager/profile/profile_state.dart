part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  String data;
  ProfileSuccess(this.data);
}

final class ProfileFailuer extends ProfileState {
  String message;
  ProfileFailuer(this.message);
}

class WalletLoading extends ProfileState {}

class WalletSuccess extends ProfileState {
  final String message;

  WalletSuccess({required this.message});
}

class WalletFailed extends ProfileState {
  final String message;
  WalletFailed({required this.message});
}

class RequestMoneyLoading extends ProfileState {}

class RequestMoneySuccess extends ProfileState {
  final String message;

  RequestMoneySuccess({required this.message});
}

class RequestMoneyFailed extends ProfileState {
  final String message;
  RequestMoneyFailed({required this.message});
}

class SubscribtionsLoading extends ProfileState {}

class SubscribtionsSuccess extends ProfileState {
  final String message;

  SubscribtionsSuccess({required this.message});
}

class SubscribtionsFailed extends ProfileState {
  final String message;
  SubscribtionsFailed({required this.message});
}

class SubscribeLoading extends ProfileState {}

class SubscribeSuccess extends ProfileState {
  final String message;
  SubscribeSuccess({required this.message});
}

class SubscribeFailed extends ProfileState {
  final String message;
  SubscribeFailed({required this.message});
}
