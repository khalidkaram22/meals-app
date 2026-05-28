import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/domain/models/meal_model.dart';
import 'package:meals_app/core/styles/app_colors.dart';
import '../../../core/styles/app_styles.dart';

class HomeFoodItemCardWidget extends StatelessWidget {
  final String? category;
  final Function()? onTap;
  final VoidCallback? addTOfav;
  final bool isSaved;

  final Meal? meal;

  const HomeFoodItemCardWidget({
    super.key,
    this.onTap,
    this.category,
    this.meal,
    this.addTOfav,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: CachedNetworkImage(
                    imageUrl: meal?.imageUrl ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 220.h,
                    errorWidget: (context, url, error) => Container(
                      height: 220.h,
                      color: AppColors.grey.withAlpha(200),
                      child: const Icon(Icons.fastfood, color: AppColors.grey),
                    ),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppColors.white.withAlpha(200),
                    child: IconButton(
                      onPressed: addTOfav,
                      icon: Icon(
                        isSaved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_outline_rounded,
                        size: 20.sp,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.sp,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(16.r),
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(
                      category ?? "category",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            Text(
              meal?.name ?? "Food Item",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.black16inter600.copyWith(fontSize: 18.sp),
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
