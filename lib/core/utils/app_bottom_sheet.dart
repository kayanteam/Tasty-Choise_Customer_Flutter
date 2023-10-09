import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/profile/profile_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/restaurants_screen.dart';

class AppBottomSheet {
  static showAddBalanceWithBank(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController ibanController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              SizedBox(height: 20.h),
              MyText(title: 'سحب رصيد', fontWeight: FontWeight.bold),
              SizedBox(height: 20.h),
              const Divider(),
              SizedBox(height: 20.h),
              MyTextField(
                controller: usernameController,
                labelText: 'اسم صاحب الحساب',
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              MyTextField(
                controller: ibanController,
                labelText: 'رقم الايبان',
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              MyTextField(
                controller: numberController,
                labelText: 'رقم الحساب',
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              MyTextField(
                controller: amountController,
                labelText: 'قيمة المبلغ',
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 50.h),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is RequestMoneyFailed) {
                    AppHelpers.navigationBack(context);
                    AppHelpers.showSnackBar(context,
                        message: state.message, error: true);
                  }
                  if (state is RequestMoneySuccess) {
                    AppHelpers.navigationBack(context);

                    AppHelpers.showSnackBar(
                      context,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RequestMoneyLoading) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  return MyElevatedButton(
                    borderRaduis: 50,
                    title: 'تأكيد',
                    onPressed: () {
                      ProfileCubit.get(context).requestMoney(
                        name: usernameController.text.trim(),
                        ibanNumber: ibanController.text.trim(),
                        accountNumber: numberController.text.trim(),
                        amount: amountController.text.trim(),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }

  static showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Align(
                child: MyContainerShape(
                  width: 60.w,
                  height: 3.h,
                  bgContainer: AppColors.GRAY,
                ),
              ),
              SizedBox(height: 20.h),
              Align(child: MyText(title: 'فلتر', fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h),
              const Divider(),
              SizedBox(height: 20.h),
              MyText(
                title: 'انواع المطاعم',
                fontSize: 16,
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 100.h,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    List<Categories> categories =
                        HomeCubit.get(context).homeData!.categories ?? [];
                    int indexSelected = HomeCubit.get(context).indexSelected;

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 80.r,
                              child: GestureDetector(
                                onTap: () {
                                  HomeCubit.get(context)
                                      .selectedCategory(index);
                                },
                                child: Column(
                                  children: [
                                    MyContainerShape(
                                      borderRadius: 8,
                                      height: 56.h,
                                      bgContainer: indexSelected == index
                                          ? AppColors.BASE_COLOR
                                          : AppColors.WHITE2,
                                      child: Image.network(
                                        categories[index].icon ?? "",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(Icons.error),
                                          );
                                        },
                                      ),
                                    ),
                                    MyText(
                                      title: categories[index].name ?? "",
                                      maxLines: 2,
                                      fontSize: 12,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w300,
                                      textOverflow: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              MyText(
                title: 'معدل السعر',
                fontSize: 16,
              ),
              SizedBox(height: 12.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return SfRangeSlider(
                    min: 0.0,
                    max: 300.0,
                    values: HomeCubit.get(context).values,
                    interval: 20,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: true,
                    shouldAlwaysShowTooltip: true,
                    onChanged: (SfRangeValues value) {
                      HomeCubit.get(context).setValue(value);
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  int indexSelected = HomeCubit.get(context).indexSelected;

                  return MyElevatedButton(
                    title: 'بحث',
                    onPressed: indexSelected == -1
                        ? null
                        : () {
                            AppHelpers.navigationBack(context);
                            AppHelpers.navigationToPage(
                              context,
                              RestaurantsScreen(
                                category: HomeCubit.get(context)
                                    .homeData!
                                    .categories![indexSelected],
                                maxPrice: HomeCubit.get(context).values.end,
                                minPrice: HomeCubit.get(context).values.start,
                              ),
                            );
                          },
                    borderRaduis: 50,
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }
}
