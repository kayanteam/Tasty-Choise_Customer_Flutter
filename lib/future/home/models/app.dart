import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/models/product_types.dart';

class App {
  List<Categories>? categories;
  List<Producttypes>? producttypes;

  App({this.categories, this.producttypes});

  App.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['producttypes'] != null) {
      producttypes = <Producttypes>[];
      json['producttypes'].forEach((v) {
        producttypes!.add(Producttypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.producttypes != null) {
      data['producttypes'] = this.producttypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
