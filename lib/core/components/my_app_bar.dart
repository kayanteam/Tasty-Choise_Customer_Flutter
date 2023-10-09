import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final double? leadingWidth;
  final Color textColor;
  final Color backgroundColor;
  final double elevation;
  final double fontSize;
  final FontWeight fontWeight;

  const MyAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title = '',
    this.leadingWidth,
    this.textColor = AppColors.BLACK,
    this.backgroundColor = AppColors.WHITE,
    this.elevation = 0,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading,
      iconTheme: IconThemeData(color: textColor),
      centerTitle: true,
      leadingWidth: leadingWidth,
      title: MyText(
        title: title,
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
