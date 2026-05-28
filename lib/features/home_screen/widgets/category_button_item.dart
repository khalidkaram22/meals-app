import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_styles.dart';

class CategoryButtonItem extends StatelessWidget {
  final String? title;
  final bool? isSelected;
  final VoidCallback? onPress;

  const CategoryButtonItem({
    super.key,
    this.title,
    this.isSelected,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        onPress ;
        // SearchNetworkService().getCategoryTopHeadlineArticle("health") ;

      },

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: OutlinedButton(
          onPressed: onPress,
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected ?? false ? AppColors.orange : AppColors.grey,
            side: BorderSide(color: AppColors.lightGrey, width: 1.sp),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          ),
          child: Text(
            title ?? "title",
            style: AppStyles.black14inter400.copyWith(
              color: AppColors.darkOrange
            ),
          ),
        ),
      ),
    );
  }
}