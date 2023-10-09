import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/order/order.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_product.dart';

class Order extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();
  Order({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                int index = OrderCubit.get(context).indexTap;
                return MyContainerShape(
                  height: 65.h,
                  paddingHorizontal: 9,
                  paddingVertical: 9,
                  bgContainer: AppColors.WHITE2,
                  borderRadius: 50,
                  child: Row(
                    children: [
                      ItemTabBar(
                        title: 'حالية',
                        isSelected: index == 0,
                        onTap: () {
                          if (index != 0) {
                            OrderCubit.get(context).changeIndex(0);
                            OrderCubit.get(context).getOrder();
                          }
                        },
                      ),
                      ItemTabBar(
                        title: 'قيد التنفيذ',
                        isSelected: index == 1,
                        onTap: () {
                          if (index != 1) {
                            OrderCubit.get(context).changeIndex(1);
                            OrderCubit.get(context).getOrder();
                          }
                        },
                      ),
                      ItemTabBar(
                          title: 'منتهية',
                          isSelected: index == 2,
                          onTap: () {
                            if (index != 2) {
                              OrderCubit.get(context).changeIndex(2);
                              OrderCubit.get(context).getOrder();
                            }
                          }),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is OrdersFailure) {
                    AppHelpers.showSnackBar(context,
                        message: state.message, error: true);
                  }
                },
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  List<OrderModel> orders = OrderCubit.get(context).orders;
                  return orders.length == 0
                      ? SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: _refreshController,
                          onRefresh: () async {
                            await OrderCubit.get(context).getOrder();
                            _refreshController.refreshCompleted();
                          },
                          child: ListView(
                            children: [
                              SizedBox(height: 200.h),
                              MyText(
                                textAlign: TextAlign.center,
                                title: 'لا توجد طلبات في الوقت الحالي',
                              ),
                            ],
                          ),
                        )
                      : SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: _refreshController,
                          onRefresh: () async {
                            await OrderCubit.get(context).getOrder();
                            _refreshController.refreshCompleted();
                          },
                          child: ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return ItemProduct(order: orders[index]);
                            },
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTabBar extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;
  const ItemTabBar(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: MyContainerShape(
          borderRadius: 40,
          bgContainer:
              isSelected ? AppColors.BASE_COLOR : AppColors.TRANSPARENT,
          child: MyText(
            title: title,
            color: isSelected ? AppColors.WHITE : AppColors.BLACK,
          ),
        ),
      ),
    );
  }
}
