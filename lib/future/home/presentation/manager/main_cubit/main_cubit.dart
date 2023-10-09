import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/future/home/models/Item_bottom_nav.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/home.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/notification_widget.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/order/order.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/profile/profile.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<ItemBottomNavModel> pages = [
    ItemBottomNavModel('الرئيسية', 'assets/images/ic_home.svg', Home()),
    ItemBottomNavModel('طلباتي', 'assets/images/ic_list.svg', Order()),
    ItemBottomNavModel(
        'الاشعارات', 'assets/images/ic_notification.svg', NotificationWidget()),
    ItemBottomNavModel('حسابي', 'assets/images/ic_profilee.svg', Profile()),
  ];

  int indexPage = 0;
  changePage(int index) {
    this.indexPage = index;
    emit(MainInitial());
  }
}
