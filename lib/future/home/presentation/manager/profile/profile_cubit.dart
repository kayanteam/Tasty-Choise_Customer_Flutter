import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/future/home/domin/profile_repo.dart';
import 'package:tasty_choise_customer/future/home/models/profile/subscribtion_model.dart';
import 'package:tasty_choise_customer/future/home/models/profile/wallet/transactions.dart';
import 'package:tasty_choise_customer/future/home/models/profile/wallet/wallet_object.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repo) : super(ProfileInitial());
  final ProfileRepo repo;

  static ProfileCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Future getSettings(String value) async {
    emit(ProfileLoading());
    (await repo.appSettings(value)).fold(
      (l) {
        emit(ProfileFailuer(l));
      },
      (r) {
        emit(ProfileSuccess(r.data));
      },
    );
  }

  List<Transactions> listTransactions = [];
  String balnce = '0';
  String currency = 'SAR';

  Future getTransactions() async {
    balnce = '0';

    emit(WalletLoading());
    (await repo.getTransactions()).fold(
      (l) {
        emit(WalletFailed(message: l));
      },
      (r) {
        WalletObject wallet = WalletObject.fromJson(r!.data);
        if (wallet.balance != null) {
          balnce = wallet.balance!;
        }
        if (wallet.currency != null) {
          currency = wallet.currency!;
        }
        listTransactions = wallet.transactions ?? [];
        emit(WalletSuccess(message: r.message!));
      },
    );
  }

  Future requestMoney({
    required String name,
    required String ibanNumber,
    required String accountNumber,
    required String amount,
  }) async {
    emit(RequestMoneyLoading());
    (await repo.requestMoney(
      ibanNumber: ibanNumber,
      name: name,
      accountNumber: accountNumber,
      amount: amount,
    ))
        .fold(
      (l) {
        emit(RequestMoneyFailed(message: l));
      },
      (r) {
        emit(RequestMoneySuccess(message: r!.message ?? ""));
        getTransactions();
      },
    );
  }

  List<SubscribeModel> subscribtions = [];

  Future getSubscribtion() async {
    subscribtions.clear();
    emit(SubscribtionsLoading());
    (await repo.subscribtions()).fold(
      (l) {
        emit(SubscribtionsFailed(message: l));
      },
      (r) {
        r.data.forEach((e) {
          subscribtions.add(SubscribeModel.fromJson(e));
        });
        emit(SubscribtionsSuccess(message: r.message!));
      },
    );
  }

  Future subscribe(int id) async {
    emit(SubscribtionsLoading());
    (await repo.subscibe(id)).fold(
      (l) {
        emit(SubscribtionsFailed(message: l));
      },
      (r) {
        getSubscribtion();
        emit(SubscribtionsSuccess(message: r.message!));
      },
    );
  }
}
