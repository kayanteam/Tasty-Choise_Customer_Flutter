import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';

import '../../../../../core/utils/app_colors.dart';

class ItemQuestions extends StatefulWidget {
  const ItemQuestions({super.key});

  @override
  State<ItemQuestions> createState() => _ItemQuestionsState();
}

class _ItemQuestionsState extends State<ItemQuestions> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyContainerShape(
          topEndRaduis: 10,
          topStartRaduis: 10,
          bottomEndRaduis: isExpanded ? 0 : 10,
          bottomStartRaduis: isExpanded ? 0 : 10,
          paddingHorizontal: 12,
          height: 55.h,
          enableShadow: false,
          bgContainer: AppColors.WHITE5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title: "كيف استطيع بحث عن خدمة",
                fontSize: 12,
                color: isExpanded ? AppColors.BASE_COLOR : null,
              ),
              Material(
                child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: AppColors.BLACK,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: MyContainerShape(
            bottomEndRaduis: 10,
            bottomStartRaduis: 10,
            alignment: AlignmentDirectional.centerStart,
            paddingHorizontal: 12,
            enableShadow: false,
            bgContainer: AppColors.WHITE2,
            height: isExpanded ? null : 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  textAlign: TextAlign.start,
                  title:
                      "هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم التحكم في هذا النص وامكانية تغييرة في اي وقت عن طريق ادارة الموقع . يتم اضافة هذا النص كنص تجريبي للمعاينة .",
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: AppColors.GRAY3,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
