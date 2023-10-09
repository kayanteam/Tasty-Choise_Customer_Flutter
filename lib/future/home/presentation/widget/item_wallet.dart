import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/profile/profile_cubit.dart';

class ItemWallet extends StatelessWidget {
  const ItemWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212.h,
      width: double.infinity,
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            bottom: 0,
            start: 0,
            child: SvgPicture.asset(
              'assets/images/ic_wallet0.svg',
              fit: BoxFit.fill,
            ),
          ),
          PositionedDirectional(
            end: 0.w,
            start: 0.w,
            bottom: 35.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/ic_wallet1.svg',
                  width: 50.r,
                  height: 50.r,
                ),
                MyText(
                  title: 'رصيد المحفظة',
                  fontSize: 16,
                  color: AppColors.WHITE,
                ),
                MyText(
                  title:
                      '${ProfileCubit.get(context).balnce}  ${ProfileCubit.get(context).currency}',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.WHITE,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
