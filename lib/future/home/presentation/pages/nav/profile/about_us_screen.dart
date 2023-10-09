import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/profile/profile_cubit.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getSettings("aboutapp");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'عن التطبيق'),
      body: Column(
        children: [
          Image.asset(
            'assets/images/ic_logo.png',
            width: 140.r,
          ),
          Expanded(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFailuer) {
                  AppHelpers.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                if (state is ProfileFailuer) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                }
                return ListView(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
          ),
        ],
      ),
    );
  }
}
