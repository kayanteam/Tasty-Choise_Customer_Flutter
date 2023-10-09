import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_bottom_sheet.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/profile/wallet/transactions.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/profile/profile_cubit.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_action_wallet.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_wallet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'المحفظة'),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is WalletFailed) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          List<Transactions> transactions =
              ProfileCubit.get(context).listTransactions;
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              const ItemWallet(),
              SizedBox(height: 30.h),
              MyElevatedButton(
                title: 'سحب رصيد',
                onPressed: () {
                  AppBottomSheet.showAddBalanceWithBank(context);
                },
                borderRaduis: 40,
                background: AppColors.WHITE,
                enabledBorder: true,
                titleColor: AppColors.BLACK,
                borderColor: AppColors.BLACK.withOpacity(.1),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_history.svg',
                    width: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  MyText(
                    fontSize: 15,
                    title: 'سجل الحركات المالية',
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              transactions.length == 0
                  ? Column(
                      children: [
                        SizedBox(height: 100.h),
                        MyText(
                          title: 'لا توجد حركات مالية حتى الان',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: transactions.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemActionWallet(data: transactions[index]);
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}
