import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/future/home/presentation/widget/item_qustions.dart';

class CommonQuestionsScreen extends StatefulWidget {
  const CommonQuestionsScreen({super.key});

  @override
  State<CommonQuestionsScreen> createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
  @override
  void initState() {
    // if (PrivacyCubit.get(context).listCommonQustion.length == 0) {
    //   PrivacyCubit.get(context).showCommonQustion();
    // }
    // _scrollController.addListener(pagination);
    super.initState();
  }

  // void pagination() async {
  //   if ((_scrollController.position.pixels ==
  //           _scrollController.position.maxScrollExtent) &&
  //       (PrivacyCubit.get(context).listCommonQustion.length <
  //           PrivacyCubit.get(context).total)) {
  //     await PrivacyCubit.get(context).showCommonQustion(loadPagination: true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'الاسئلة الشائعة'),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ItemQuestions(),
              SizedBox(height: 12.h),
            ],
          );
        },
      ),
    );
  }
}
