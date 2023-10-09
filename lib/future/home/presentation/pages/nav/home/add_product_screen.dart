import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/custom_dropdown_menu.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/components/pick_media_product_widget.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/models/my_media.dart';
import 'package:tasty_choise_customer/future/home/models/product.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';

class AddProductScreen extends StatefulWidget {
  final Product? product;
  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int categoryId = -1;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    List<Categories>? categories =
        HomeCubit.get(context).appConfig!.categories!;
    categoryId = categories.length > 0 ? categories[0].id! : -1;
    if (widget.product != null) {
      HomeCubit.get(context).media.add(
            MyMedia(file: null, imageNetwork: widget.product!.image),
          );

      _nameController.text = widget.product!.name ?? "";
      _priceController.text = widget.product!.price ?? "";
      _descController.text = widget.product!.description ?? "";
    }

    super.initState();
  }

  @override
  void deactivate() {
    HomeCubit.get(context).media.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MyAppBar(title: widget.product == null ? 'اضافة منتج' : 'تعديل منتج'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 10.h),
            MyContainerShape(
              borderRadius: 12,
              paddingHorizontal: 17,
              paddingVertical: 12,
              bgContainer: AppColors.WHITE2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: 'صور المنتج',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 12.h),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return PickMediaWidget(
                        pickSingle: true,
                        media: HomeCubit.get(context).media,
                        onTapDelete: (int index) {
                          HomeCubit.get(context).deleteMedia(index);
                        },
                        onTapPickMedia: () {
                          HomeCubit.get(context).pickMedia();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            MyContainerShape(
              bgContainer: AppColors.WHITE2,
              borderRadius: 12,
              paddingHorizontal: 12,
              paddingVertical: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(title: 'معلومات المنتج'),
                  SizedBox(height: 16.h),
                  MyTextField(
                    controller: _nameController,
                    textHint: '',
                    labelText: 'اسم المنتج',
                    fillColor2: AppColors.WHITE,
                    isBorder: true,
                    hintColor: AppColors.BLACK.withOpacity(.7),
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                  SizedBox(height: 10.h),
                  CustomDropdownMenu(
                    background: AppColors.WHITE,
                    paddingHorizontal: 10,
                    isExpanded: true,
                    height: 60,
                    alignment: AlignmentDirectional.centerStart,
                    listItems: HomeCubit.get(context)
                        .appConfig!
                        .categories!
                        .map((e) => e.name!)
                        .toList(),
                    borderRadius: 8,
                    enabledBorder: true,
                    iconDropdown: Icon(Icons.arrow_drop_down_outlined),
                    onChanged: (String? s) {
                      int index = HomeCubit.get(context)
                          .appConfig!
                          .categories!
                          .indexWhere((element) => element.name == s);
                      categoryId = HomeCubit.get(context)
                          .appConfig!
                          .categories![index]
                          .id!;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: MyText(title: 'سعر الوحدة'),
                      ),
                      Expanded(
                        flex: 2,
                        child: MyTextField(
                          controller: _priceController,
                          textHint: '',
                          fillColor2: AppColors.WHITE,
                          isBorder: true,
                          validator: (p0) =>
                              AppHelpers.checkFillData(p0, context),
                          hintColor: AppColors.BLACK.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  MyTextField(
                    controller: _descController,
                    textHint: 'وصف المنتج',
                    labelText: '',
                    fillColor2: AppColors.WHITE,
                    isBorder: true,
                    maxLines: 8,
                    hintColor: AppColors.BLACK.withOpacity(.7),
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is AddProductSuccessData) {
                  AppHelpers.showSnackBar(context, message: state.message);
                  AppHelpers.navigationBack(context);
                }
                if (state is AddProductFailureData) {
                  AppHelpers.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              builder: (context, state) {
                if (state is AddProductLoadingData) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                return MyElevatedButton(
                  title: widget.product == null ? 'اضافة' : 'تعديل',
                  onPressed: () {
                    if (HomeCubit.get(context).media.length == 0) {
                      AppHelpers.showSnackBar(context,
                          message: 'الرجاء اختر صورة للمنتج', error: true);
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      HomeCubit.get(context).storeProduct(
                        productId:
                            widget.product == null ? null : widget.product!.id,
                        image: HomeCubit.get(context).media[0].file == null
                            ? null
                            : HomeCubit.get(context).media[0].file!.path!,
                        name: _nameController.text.trim(),
                        description: _descController.text.trim(),
                        price: _priceController.text.trim(),
                        categoryId: categoryId.toString(),
                      );
                    }
                  },
                  borderRaduis: 30,
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
          ],
        ),
      ),
    );
  }
}
