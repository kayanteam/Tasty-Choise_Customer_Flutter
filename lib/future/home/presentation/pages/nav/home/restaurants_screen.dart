import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/home/restaurant_details_screen.dart';

class RestaurantsScreen extends StatefulWidget {
  final Categories? category;
  final double? maxPrice;
  final double? minPrice;
  const RestaurantsScreen({
    super.key,
    required this.category,
    required this.maxPrice,
    required this.minPrice,
  });

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getRestaurants(
      widget.category == null ? null : widget.category!.id!,
      maxPrice: widget.maxPrice,
      minPrice: widget.minPrice,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.category == null ? "" : widget.category!.name ?? "",
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is RestaurentFailure) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is RestaurentLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is RestaurentFailure) {
            return const Center(child: Icon(Icons.error));
          }
          List<Categories> resturants = HomeCubit.get(context).resturents;
          if (resturants.length == 0) {
            return Center(
                child: MyText(title: 'لا توجد مطاعم في الوقت الحالي'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 170 / 190,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
            ),
            itemCount: resturants.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AppHelpers.navigationToPage(context,
                      RestaurantDetailsScreen(category: resturants[index]));
                },
                child: MyContainerShape(
                  borderRadius: 8,
                  bgContainer: AppColors.WHITE2,
                  paddingHorizontal: 12,
                  paddingVertical: 12,
                  child: Column(
                    children: [
                      MyContainerShape(
                        height: 130.h,
                        borderRadius: 8,
                        child: Image.network(
                          resturants[index].image ?? "",
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      Spacer(),
                      MyText(
                        title: resturants[index].name ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
