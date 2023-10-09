import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/order/order.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/order/order_details_screen.dart';

class ItemProduct extends StatelessWidget {
  final OrderModel order;
  const ItemProduct({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            AppHelpers.navigationToPage(
                context, OrderDetailsScreen(order: order));
          },
          child: MyContainerShape(
            borderRadius: 12,
            paddingHorizontal: 12,
            bgContainer: AppColors.WHITE2,
            paddingVertical: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  order.product!.image ?? "",
                  width: 80.w,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      width: 80.r,
                      height: 80.r,
                      child: Center(child: Icon(Icons.error)),
                    );
                  },
                ),
                SizedBox(width: 22.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: '${order.product!.price} ر.س',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          MyText(
                            title: order.createdAt ?? "",
                            fontSize: 10,
                            color: AppColors.GRAY,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              title: order.product!.name ?? "",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      const Divider(height: 1),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              title: order.user!.name ?? "",
                              fontSize: 10,
                              color: AppColors.GRAY3,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          MyText(
                            title: '${order.id}#',
                            fontSize: 10,
                            color: AppColors.GRAY3,
                            fontWeight: FontWeight.w300,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
