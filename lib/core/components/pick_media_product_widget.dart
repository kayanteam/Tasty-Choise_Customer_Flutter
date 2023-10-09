import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/future/home/models/my_media.dart';

class PickMediaWidget extends StatelessWidget {
  final Function() onTapPickMedia;
  final Function(int index) onTapDelete;
  final List<MyMedia> media;
  final bool pickSingle;

  const PickMediaWidget({
    super.key,
    required this.onTapPickMedia,
    required this.media,
    required this.onTapDelete,
    this.pickSingle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!pickSingle || media.isEmpty)
          GestureDetector(
            onTap: onTapPickMedia,
            child: SizedBox(
              height: 80.r,
              width: 80.r,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/bg_pick_cam.svg',
                    height: 80.r,
                    width: 80.r,
                  ),
                  const Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            height: 80.r,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: media.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsetsDirectional.only(end: 10.w),
                  height: 80.r,
                  width: 80.r,
                  child: Stack(
                    children: [
                      MyContainerShape(
                        height: 80.r,
                        borderRadius: 4,
                        width: 80.r,
                        child: media[index].imageNetwork == null
                            ? Image.file(
                                File(media[index].file!.extension == 'mp4'
                                    ? media[index].thum!
                                    : media[index].file!.path!),
                                height: 80.r,
                                width: 80.r,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                media[index].imageNetwork!,
                                height: 80.r,
                                width: 80.r,
                                fit: BoxFit.cover,
                              ),
                      ),
                      if (media[index].file != null)
                        Center(
                          child: Icon(
                            media[index].file!.extension == 'mp4'
                                ? Icons.video_collection_outlined
                                : Icons.camera_alt_outlined,
                            color: AppColors.BLACK.withOpacity(.2),
                          ),
                        ),
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: GestureDetector(
                          onTap: () {
                            onTapDelete(index);
                          },
                          child: MyContainerShape(
                            width: 24.r,
                            height: 24.r,
                            bgContainer: AppColors.BLACK.withOpacity(.5),
                            borderRadius: 20,
                            child: const Icon(
                              Icons.close,
                              color: AppColors.WHITE,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
