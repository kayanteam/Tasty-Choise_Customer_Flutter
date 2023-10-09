import 'package:tasty_choise_customer/core/network/home_api.dart';
import 'package:tasty_choise_customer/core/network/profile_api.dart';
import 'package:tasty_choise_customer/future/home/domin/profile_repo.dart';
import 'package:tasty_choise_customer/future/home/models/general_response.dart';

class ProfileRepoImp extends ProfileRepo {
  final ProfileApi api;

  ProfileRepoImp({required this.api});

  @override
  EitherType<GeneralResponse> appSettings(String value) {
    return api.appSettings(value);
  }

  @override
  EitherType<GeneralResponse> getTransactions() {
    return api.getTransaction();
  }

  @override
  EitherType<GeneralResponse?> requestMoney({
    required String name,
    required String ibanNumber,
    required String accountNumber,
    required String amount,
  }) {
    return api.requestMoney(
        name: name,
        ibanNumber: ibanNumber,
        accountNumber: accountNumber,
        amount: amount);
  }

  @override
  EitherType<GeneralResponse> subscribtions() {
    return api.getSubscribtions();
  }

  @override
  EitherType<GeneralResponse> subscibe(int id) {
    return api.subscribe(id);
  }
}
