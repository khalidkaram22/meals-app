import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/styles/app_colors.dart';

class IndexWidget extends StatelessWidget {
  final int index;
  final int length;

  const IndexWidget({
    super.key,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 24.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: index == i ? AppColors.white : AppColors.grey,
            borderRadius: BorderRadius.circular(100.r),
          ),
        );
      }),
    );
  }
}