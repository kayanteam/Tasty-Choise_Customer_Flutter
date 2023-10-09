import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_page_view.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:tasty_choise_customer/core/utils/app_bottom_sheet.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/core/utils/app_loader.dart';
import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/models/product.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/product_details_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/restaurants_screen.dart';

class Home extends StatelessWidget {
  final TextEditingController _priceController = TextEditingController();
  final GlobalKey<FormState> _fomKey = GlobalKey();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteProductLoadingData) {
            AppLoaderDialog.show(context);
          }
          if (state is DeleteProductSuccessData) {
            AppLoaderDialog.hide(context);
            AppHelpers.showSnackBar(context, message: state.message);
          }
          if (state is DeleteProductFailureData) {
            AppLoaderDialog.hide(context);
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingData) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is HomeFailureData) {
            return const Center(
              child: Icon(
                Icons.error,
                color: AppColors.RED,
              ),
            );
          }
          List<Product> prodtucts =
              HomeCubit.get(context).homeData!.prodtucts ?? [];
          List<Categories> categories =
              HomeCubit.get(context).homeData!.categories ?? [];

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyContainerShape(
                    height: 58.r,
                    width: 58.r,
                    borderRadius: 50,
                    bgContainer: AppColors.BASE_COLOR,
                    child: SharedPrefController().getDataUser().image == null
                        ? const Icon(
                            Icons.person,
                            size: 30,
                          )
                        : Image.network(
                            SharedPrefController().getDataUser().image!,
                            height: 58.r,
                            width: 58.r,
                          ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        MyText(title: 'حياك الله،👋'),
                        SizedBox(height: 2.h),
                        MyText(
                            title:
                                SharedPrefController().getDataUser().name ?? "",
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppBottomSheet.showFilter(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/ic_filter.svg',
                      width: 55.r,
                      height: 55.r,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              MyPageView(
                images: HomeCubit.get(context)
                    .homeData!
                    .ads!
                    .map((e) => e.image ?? "")
                    .toList(),
              ),
              SizedBox(height: 16.h),
              MyText(
                title: 'سعر الوجبة',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _fomKey,
                      child: MyTextField(
                        controller: _priceController,
                        textHint: '00.00',
                        keyboardType: TextInputType.number,
                        validator: (p0) =>
                            AppHelpers.checkFillData(p0, context),
                        suffixWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [MyText(title: 'رس')],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      if (_fomKey.currentState!.validate()) {
                        AppHelpers.navigationToPage(
                          context,
                          RestaurantsScreen(
                            category: null,
                            maxPrice:
                                double.parse(_priceController.text.trim()),
                            minPrice:
                                double.parse(_priceController.text.trim()),
                          ),
                        );
                      }
                    },
                    child: MyContainerShape(
                      height: 45.r,
                      width: 45.r,
                      borderRadius: 50,
                      bgContainer: AppColors.BASE_COLOR,
                      child: const Icon(Icons.search, color: AppColors.WHITE),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              MyText(
                title: 'انواع المطاعم',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 80.r,
                          child: GestureDetector(
                            onTap: () {
                              AppHelpers.navigationToPage(
                                context,
                                RestaurantsScreen(
                                  category: categories[index],
                                  maxPrice: null,
                                  minPrice: null,
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                MyContainerShape(
                                  borderRadius: 8,
                                  height: 56.h,
                                  bgContainer: AppColors.WHITE2,
                                  child: Image.network(
                                    categories[index].icon ?? "",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
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
                ),
              ),
              SizedBox(height: 32.h),
              MyText(
                title: 'أفضل المنتجات',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 16.h),
              prodtucts.length == 0
                  ? Align(child: MyText(title: 'لا توجد منتجات حتى الان'))
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: prodtucts.length,
                      padding: EdgeInsets.only(bottom: 20.h),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 166 / 190,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 10.w,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            AppHelpers.navigationToPage(
                                context,
                                ProductDetailsScreen(
                                  productId: prodtucts[index].id!,
                                ));
                          },
                          child: MyContainerShape(
                            bgContainer: AppColors.WHITE2,
                            borderRadius: 12,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.r,
                                    vertical: 12.r,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Image.network(
                                        prodtucts[index].image!,
                                        height: 110.r,
                                        width: 110.r,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return MyContainerShape(
                                            height: 110.r,
                                            width: 110.r,
                                            child: Icon(Icons.error),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 15.h),
                                      MyText(
                                        title: prodtucts[index].name ?? "",
                                        fontSize: 12,
                                      ),
                                      MyText(
                                        title:
                                            '${prodtucts[index].price ?? ""} ر.س',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}
