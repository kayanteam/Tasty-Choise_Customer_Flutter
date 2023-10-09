import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/main_cubit/main_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_bottom_nav.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      topEndRaduis: 32,
      topStartRaduis: 32,
      height: 90.r,
      enableShadow: true,
      blur: 50,
      shadow: AppColors.BLACK.withOpacity(.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              int page = MainCubit.get(context).indexPage;

              return Row(
                children: [
                  Expanded(
                    child: ItemBottomNav(
                      MainCubit.get(context).pages[0],
                      page == 0,
                      () {
                        MainCubit.get(context).changePage(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: ItemBottomNav(
                      MainCubit.get(context).pages[1],
                      page == 1,
                      () {
                        MainCubit.get(context).changePage(1);
                      },
                    ),
                  ),
                  Expanded(
                    child: ItemBottomNav(
                      MainCubit.get(context).pages[2],
                      page == 2,
                      () {
                        MainCubit.get(context).changePage(2);
                      },
                    ),
                  ),
                  Expanded(
                    child: ItemBottomNav(
                      MainCubit.get(context).pages[3],
                      page == 3,
                      () {
                        MainCubit.get(context).changePage(3);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
