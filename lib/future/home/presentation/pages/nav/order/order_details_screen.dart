import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/order/order.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_product.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'تفاصيل الطلب'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(height: 20.h),
          ItemProduct(order: order),
          SizedBox(height: 16.h),
          const Divider(height: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(title: 'حالة الطلب'),
              MyContainerShape(
                width: 100.w,
                paddingVertical: 6,
                borderRadius: 40,
                bgContainer: AppColors.RED.withOpacity(.1),
                child: MyText(
                  title: order.status ?? "",
                  color: AppColors.RED,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is UpdateOrderStatusFailure) {
              AppHelpers.showSnackBar(context,
                  message: state.message, error: true);
            }
            if (state is UpdateOrderStatusSuccess) {
              OrderCubit.get(context).getOrder();
              AppHelpers.showSnackBar(context, message: state.message);
              AppHelpers.navigationBack(context);
            }
          },
          builder: (context, state) {
            if (state is UpdateOrderStatusLoading) {
              return const Align(child: CircularProgressIndicator.adaptive());
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (OrderCubit.get(context).indexTap == 0) ...[
                  MyElevatedButton(
                    title: 'الغاء الطلب',
                    onPressed: () {
                      OrderCubit.get(context)
                          .updartOrder(status: 'canceled', orderId: order.id!);
                    },
                    borderRaduis: 30,
                    iconPath: 'assets/images/ic_delete_order.svg',
                    iconColor: AppColors.BASE_COLOR,
                    background: AppColors.TRANSPARENT,
                    titleColor: AppColors.BASE_COLOR,
                    borderColor: AppColors.BASE_COLOR,
                  ),
                ],
                if (order.status == 'done') ...[
                  MyElevatedButton(
                    title: 'تاكيد الاستلام',
                    onPressed: () {
                      OrderCubit.get(context)
                          .updartOrder(status: 'finished', orderId: order.id!);
                    },
                    background: AppColors.WHITE5,
                    iconPath: 'assets/images/ic_order_complete.svg',
                    borderRaduis: 30,
                    titleColor: AppColors.BLACK,
                    iconColor: AppColors.BLACK,
                  ),
                ],
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
