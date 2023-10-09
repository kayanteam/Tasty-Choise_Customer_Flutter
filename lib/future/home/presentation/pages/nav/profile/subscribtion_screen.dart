import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/core/utils/app_loader.dart';
import 'package:tasty_choise_customer/future/home/models/profile/subscribtion_model.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/profile/profile_cubit.dart';

class SubscirbtionScreen extends StatefulWidget {
  const SubscirbtionScreen({super.key});

  @override
  State<SubscirbtionScreen> createState() => _SubscirbtionScreenState();
}

class _SubscirbtionScreenState extends State<SubscirbtionScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getSubscribtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'باقات الاشتراك'),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SubscribtionsFailed) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }

          if (state is SubscribeFailed) {
            AppLoaderDialog.hide(context);
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }

          if (state is SubscribeSuccess) {
            AppLoaderDialog.hide(context);
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }

          if (state is SubscribeLoading) {
            AppLoaderDialog.show(context);
          }
        },
        builder: (context, state) {
          if (state is SubscribtionsLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          List<SubscribeModel> subs = ProfileCubit.get(context).subscribtions;
          return ListView.builder(
            itemCount: subs.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemBuilder: (context, index) {
              return MyContainerShape(
                borderRadius: 12,
                marginBottom: 20,
                bgContainer: AppColors.WHITE2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: MyContainerShape(
                        paddingHorizontal: 10,
                        paddingVertical: 10,
                        width: 150,
                        bottomStartRaduis: 0,
                        bgContainer: AppColors.BASE_COLOR.withOpacity(.3),
                        child: MyText(
                          title: '${subs[index].price}ر.س',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 13.r),
                      child: Row(
                        children: [
                          MyContainerShape(
                            height: 55.r,
                            width: 55.r,
                            bgContainer: AppColors.BASE_COLOR.withOpacity(.1),
                            borderRadius: 100,
                            child: SvgPicture.asset(
                              'assets/images/settings/ic_subscribtion.svg',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  title: subs[index].name ?? "",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 5.h),
                                MyText(
                                  title: "${subs[index].days} يوم",
                                  fontSize: 14,
                                ),
                                SizedBox(height: 5.h),
                                MyText(
                                  title: subs[index].hasOrder == 1
                                      ? 'تسمح للك بتلقي طلبات على منتاجتك'
                                      : 'لا تسمح للك بتلقي طلبات على منتاجتك',
                                  fontSize: 14,
                                  color: AppColors.GRAY3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyElevatedButton(
                          height: 45,
                          width: 200,
                          background: subs[index].isSubscribed == 'unsubscribe'
                              ? AppColors.BASE_COLOR
                              : AppColors.GREEN,
                          title: subs[index].isSubscribed == 'unsubscribe'
                              ? 'اشتراك'
                              : 'مشترك',
                          onPressed: subs[index].isSubscribed == 'unsubscribe'
                              ? () {
                                  ProfileCubit.get(context)
                                      .subscribe(subs[index].id!);
                                }
                              : null,
                          borderRaduis: 30,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
