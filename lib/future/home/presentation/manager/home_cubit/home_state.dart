part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingData extends HomeState {}

class SuccessData extends HomeState {}

class FailureData extends HomeState {
  final String message;
  FailureData(this.message);
}

class HomeLoadingData extends HomeState {}

class HomeSuccessData extends HomeState {}

class HomeFailureData extends HomeState {
  final String message;
  HomeFailureData(this.message);
}

class AddProductLoadingData extends HomeState {}

class AddProductSuccessData extends HomeState {
  final String message;
  AddProductSuccessData(this.message);
}

class AddProductFailureData extends HomeState {
  final String message;
  AddProductFailureData(this.message);
}

class DeleteProductLoadingData extends HomeState {}

class DeleteProductSuccessData extends HomeState {
  final String message;
  DeleteProductSuccessData(this.message);
}

class DeleteProductFailureData extends HomeState {
  final String message;
  DeleteProductFailureData(this.message);
}

class RestaurentLoading extends HomeState {}

class RestaurentSuccess extends HomeState {}

class RestaurentFailure extends HomeState {
  final String message;
  RestaurentFailure(this.message);
}

class RestaurentProductsLoading extends HomeState {}

class RestaurentProductsSuccess extends HomeState {}

class RestaurentProductsFailure extends HomeState {
  final String message;
  RestaurentProductsFailure(this.message);
}

class ProductDetailsLoading extends HomeState {}

class ProductDetailsSuccess extends HomeState {}

class ProductDetailsFailure extends HomeState {
  final String message;
  ProductDetailsFailure(this.message);
}

class MakeOrderLoading extends HomeState {}

class MakeOrderSuccess extends HomeState {
  final String message;
  MakeOrderSuccess(this.message);
}

class MakeOrderFailure extends HomeState {
  final String message;
  MakeOrderFailure(this.message);
}
