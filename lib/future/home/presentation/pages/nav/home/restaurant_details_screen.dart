import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/models/product.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/product_details_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Categories category;
  const RestaurantDetailsScreen({super.key, required this.category});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getRestaurantProducts(widget.category.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const MyAppBar(
        elevation: 0,
        backgroundColor: AppColors.TRANSPARENT,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 230.h,
            child: Stack(
              children: [
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        start: 0,
                        end: 0,
                        child: SvgPicture.asset(
                          'assets/images/bg_update_profile.svg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Image.asset(
                        'assets/images/bg_shape.png',
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  bottom: 0,
                  child: Align(
                    child: MyContainerShape(
                      width: 128.r,
                      paddingVertical: 2,
                      height: 128.r,
                      paddingHorizontal: 2,
                      enableShadow: false,
                      shadow: AppColors.BLACK.withOpacity(0.1),
                      borderRadius: 100,
                      alignment: AlignmentDirectional.centerStart,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/ic_shape.svg',
                            width: 62.r,
                          ),
                          Center(
                            child: Image.network(
                              widget.category.icon ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  top: MediaQuery.of(context).padding.top + 10.h,
                  child: MyText(
                    title: widget.category.name ?? "",
                    textAlign: TextAlign.center,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.WHITE,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is RestaurentProductsFailure) {
                AppHelpers.showSnackBar(context,
                    message: state.message, error: true);
              }
            },
            builder: (context, state) {
              if (state is RestaurentProductsLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              if (state is RestaurentProductsFailure) {
                return const Center(child: Icon(Icons.error));
              }
              List<Product> listProduct =
                  HomeCubit.get(context).resturentProducts;
              return ListView.builder(
                itemCount: listProduct.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppHelpers.navigationToPage(
                              context,
                              ProductDetailsScreen(
                                productId: listProduct[index].id!,
                              ));
                        },
                        child: MyContainerShape(
                          borderRadius: 12,
                          paddingHorizontal: 12,
                          bgContainer: AppColors.WHITE2,
                          paddingVertical: 12,
                          child: Row(
                            children: [
                              Image.network(
                                listProduct[index].image ?? "",
                                width: 80.w,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    width: 80.r,
                                    height: 80.r,
                                    child:
                                        const Center(child: Icon(Icons.error)),
                                  );
                                },
                              ),
                              SizedBox(width: 22.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      title: listProduct[index].name ?? "",
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(height: 8.h),
                                    MyText(
                                      title: '${listProduct[index].price} ر.س',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
