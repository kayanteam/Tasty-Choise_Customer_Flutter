import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/core/utils/app_loader.dart';
import 'package:tasty_choise_customer/future/home/models/product.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/success_order_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int count = 1;

  @override
  void initState() {
    HomeCubit.get(context).getProductDetails(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const MyAppBar(
        backgroundColor: AppColors.TRANSPARENT,
        leadingWidth: 100,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is ProductDetailsFailure) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
          if (state is MakeOrderLoading) {
            AppLoaderDialog.show(context);
          }
          if (state is MakeOrderFailure) {
            AppLoaderDialog.hide(context);
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }

          if (state is MakeOrderSuccess) {
            AppLoaderDialog.hide(context);
            AppHelpers.navigationReplacementToPage(
                context, SuccessOrderScreen());

            AppHelpers.showSnackBar(context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is ProductDetailsFailure) {
            return const Center(child: Icon(Icons.error));
          }
          Product product = HomeCubit.get(context).productDetails!;
          print(product.hasOrder);
          print('object');
          print(product.hasOrder);

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              MyContainerShape(
                borderRadius: 12,
                width: double.infinity,
                bgContainer: AppColors.WHITE2,
                height: 280.h,
                child: Image.network(
                  product.image!,
                  height: 200.r,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      title: product.name ?? "",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  MyText(
                    title: product.price ?? "",
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  MyContainerShape(
                    height: 30.r,
                    width: 30.r,
                    borderRadius: 100,
                    child: Image.network(
                      product.restaurantImage ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  MyText(title: product.restaurant ?? ""),
                ],
              ),
              SizedBox(height: 15.h),
              const Divider(),
              SizedBox(height: 15.h),
              MyText(title: 'وصف المنتج'),
              const SizedBox(height: 7),
              MyText(
                title: product.description ?? "",
                fontSize: 14,
                color: AppColors.GRAY,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              MyText(title: 'ملاحظات'),
              const SizedBox(height: 5),
              MyTextField(
                textHint: '',
                isBorder: true,
                fillColor2: AppColors.WHITE2,
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              const Divider(),
              if (product.hasOrder == "1") ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    MyText(
                      title: 'الكمية',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 20.w),
                    MyContainerShape(
                      paddingHorizontal: 12,
                      paddingVertical: 10,
                      borderRadius: 8,
                      bgContainer: AppColors.WHITE2,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              count++;
                              setState(() {});
                            },
                            child: MyContainerShape(
                              height: 32.r,
                              width: 32.r,
                              borderRadius: 4,
                              child: const Icon(
                                Icons.add,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          MyText(title: '$count'),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              if (count > 1) {
                                count--;
                                setState(() {});
                              }
                            },
                            child: MyContainerShape(
                              height: 32.r,
                              width: 32.r,
                              borderRadius: 4,
                              child: const Icon(
                                Icons.remove,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 32),
                MyContainerShape(
                  bgContainer: Color(0xffEEEFF2),
                  paddingHorizontal: 12,
                  paddingVertical: 12,
                  borderRadius: 8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: 'اجمالي المبلغ',
                              fontSize: 12,
                            ),
                            MyText(
                              title:
                                  '${count * double.parse(product.price!)} ر.س',
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: MyElevatedButton(
                          title: 'تاكيد الطلب',
                          onPressed: () {
                            HomeCubit.get(context)
                                .makeOrder(product.id!, count);
                          },
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70.h),
              ]
            ],
          );
        },
      ),
    );
  }
}
