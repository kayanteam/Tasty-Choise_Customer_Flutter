import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/main_cubit/main_cubit.dart';

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        int page = MainCubit.get(context).indexPage;
        switch (page) {
          case 0:
            return MainCubit.get(context).pages[page].widget;

          case 1:
            return MainCubit.get(context).pages[page].widget;

          case 2:
            return MainCubit.get(context).pages[page].widget;

          case 3:
            return MainCubit.get(context).pages[page].widget;
          default:
            return const SizedBox();
        }
      },
    );
  }
}
