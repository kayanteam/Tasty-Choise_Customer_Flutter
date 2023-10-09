import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/future/home/models/Item_bottom_nav.dart';

class ItemBottomNav extends StatelessWidget {
  final ItemBottomNavModel item;
  final bool isSelected;
  final Function()? onTap;

  const ItemBottomNav(this.item, this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          MyContainerShape(
            height: 36.r,
            width: 36.r,
            borderRadius: 50,
            bgContainer: isSelected ? AppColors.BASE_COLOR : AppColors.WHITE,
            child: SvgPicture.asset(
              item.icon,
              color: isSelected ? AppColors.WHITE : null,
            ),
          ),
          SizedBox(height: 4.h),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              height: isSelected ? null : 0,
              child: MyText(
                title: item.text,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
