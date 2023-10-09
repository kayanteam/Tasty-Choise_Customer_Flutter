import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/future/home/models/profile/wallet/transactions.dart';

class ItemActionWallet extends StatelessWidget {
  const ItemActionWallet({
    super.key,
    required this.data,
  });
  final Transactions data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: '${data.amount} ${data.currency}',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(
                            title: data.createdAt ?? "",
                            fontSize: 12,
                            color: AppColors.GRAY3,
                          ),
                        ],
                      ),
                      MyText(
                        title: data.type ?? "",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
