class SubscribeModel {
  int? id;
  String? name;
  String? price;
  String? days;
  int? hasOrder;
  String? isSubscribed;

  SubscribeModel(
      {this.id,
      this.name,
      this.price,
      this.days,
      this.hasOrder,
      this.isSubscribed});

  SubscribeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    days = json['days'];
    hasOrder = json['has_order'];
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['days'] = this.days;
    data['has_order'] = this.hasOrder;
    data['is_subscribed'] = this.isSubscribed;
    return data;
  }
}
