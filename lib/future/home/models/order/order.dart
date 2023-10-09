import 'package:tasty_choise_customer/future/auth/models/user_model.dart';
import 'package:tasty_choise_customer/future/home/models/product.dart';

class OrderModel {
  int? id;
  String? orderNum;
  UserModel? user;
  String? status;
  String? createdAt;
  Product? product;

  OrderModel(
      {this.id,
      this.orderNum,
      this.user,
      this.status,
      this.createdAt,
      this.product});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['order_num'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    status = json['status'];
    createdAt = json['created_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_num'] = this.orderNum;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
