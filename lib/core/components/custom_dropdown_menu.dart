// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';

class CustomDropdownMenu extends StatefulWidget {
  List<String> listItems;
  double? width;
  double? height;
  bool enabledBorder;
  AlignmentDirectional alignment;
  double paddingHorizontal;
  Color textColor;
  Color background;
  bool isDense;
  Widget? iconDropdown;
  bool isExpanded;
  bool textDirectionLTR;
  bool notify;
  String? initValue;
  Function onChanged;
  double fontSize;
  String? hint;
  double? borderRadius;
  Widget? iconLeading;

  CustomDropdownMenu({
    super.key,
    required this.listItems,
    required this.onChanged,
    this.enabledBorder = true,
    this.isDense = false,
    this.alignment = AlignmentDirectional.center,
    this.width,
    this.height,
    this.paddingHorizontal = 20,
    this.textColor = AppColors.BLACK,
    this.iconDropdown,
    this.isExpanded = false,
    this.textDirectionLTR = false,
    this.notify = false,
    this.initValue,
    this.fontSize = 14,
    this.hint,
    this.borderRadius,
    this.iconLeading,
    this.background = AppColors.TRANSPARENT,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? initValue;
  @override
  void initState() {
    if (widget.hint == null) {
      initValue = widget.listItems[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notify && widget.hint == null) {
      initValue =
          (widget.initValue != null ? widget.listItems[0] : widget.initValue)!;
    }
    return MyContainerShape(
      width: widget.width,
      height: widget.height,
      paddingHorizontal: widget.paddingHorizontal,
      alignment: widget.alignment,
      enableRadius: true,
      enableBorder: widget.enabledBorder,
      enableShadow: false,
      bgContainer: widget.background,
      borderRadius: widget.borderRadius ?? 10,
      widthBorder: 1,
      child: Row(
        children: [
          if (widget.iconLeading != null) ...[widget.iconLeading!],
          Expanded(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10.r),
              alignment: widget.alignment,
              underline: const SizedBox(),
              isExpanded: widget.isExpanded,
              value: initValue,
              hint: widget.hint != null
                  ? MyText(
                      title: widget.hint!,
                      fontSize: 14,
                      color: AppColors.GRAY,
                      fontWeight: FontWeight.w300,
                    )
                  : null,
              isDense: widget.isDense,
              icon: setIcon(),
              dropdownColor: AppColors.WHITE,
              items: widget.listItems.map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  alignment: widget.alignment,
                  child: widget.textDirectionLTR
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: MyText(
                            textAlign: TextAlign.center,
                            title: items,
                            fontSize: widget.fontSize,
                            color: widget.textColor,
                          ),
                        )
                      : MyText(
                          textAlign: TextAlign.center,
                          title: items,
                          fontSize: widget.fontSize,
                          color: widget.textColor,
                        ),
                );
              }).toList(),
              onChanged: (String? s) {
                if (s != null) {
                  initValue = s;
                  setState(() {
                    widget.onChanged(s);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget setIcon() {
    if (widget.iconDropdown != null) {
      return widget.iconDropdown!;
    }
    return Row(
      children: [
        SizedBox(width: 5.w),
        Icon(Icons.arrow_drop_down_outlined),
      ],
    );
  }
}
