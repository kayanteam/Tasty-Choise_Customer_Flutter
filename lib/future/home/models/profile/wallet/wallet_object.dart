import 'package:tasty_choise_customer/future/home/models/profile/wallet/transactions.dart';

class WalletObject {
  int? id;
  String? balance;
  String? currency;
  List<Transactions>? transactions;

  WalletObject({this.id, this.balance, this.currency, this.transactions});

  WalletObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'].toString();
    currency = json['currency'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }
}
