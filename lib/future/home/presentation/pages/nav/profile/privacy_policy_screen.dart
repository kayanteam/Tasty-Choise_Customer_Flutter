import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/profile/profile_cubit.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getSettings("privacy-policy");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'سياسة خصوصية'),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailuer) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is ProfileFailuer) {
            return const Center(
              child: Icon(Icons.error),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            children: [
              MyText(
                title: (state as ProfileSuccess).data,
                fontSize: 14,
                color: Color(0xff606E7D),
                fontWeight: FontWeight.w300,
                height: 1.7,
              ),
            ],
          );
        },
      ),
    );
  }
}
