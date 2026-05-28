import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/styles/app_colors.dart';
import 'package:meals_app/core/styles/app_styles.dart';

class FoodItemCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rate;
  final String? time;
  final Function()? onTap;

  const FoodItemCard({
    super.key,
    this.onTap,
    this.imageUrl,
    this.name,
    this.rate,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        // width: 153.w,
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUrl != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl ?? "aaa",
                        fit: BoxFit.cover,
                        width: 137.w,
                        height: 106.h,
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/Image.png",
                          fit: BoxFit.cover,
                          width: 137.w,
                          height: 106.h,
                        ),
                      ),
                    )
                  : Image.asset(
                      "assets/images/Image.png",
                      fit: BoxFit.cover,
                      width: 137.w,
                      height: 106.h,
                    ),

              // SizedBox(height: 8.h,),
              SizedBox(
                width: 120.w,
                child: Text(
                  name ?? "burger",
                  maxLines: 1,
                  style: AppStyles.black16inter600,
                ),
              ),

              SizedBox(height: 4.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.orange,
                        size: 16.sp,
                      ),

                      SizedBox(width: 4.w),

                      Text(
                        "${rate ?? " 4.9"}",
                        style: AppStyles.black14inter400.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 35.w),

                  Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: AppColors.orange,
                        size: 16.sp,
                      ),

                      SizedBox(width: 4.h),

                      Text(
                        time ?? "20 - 30",
                        style: AppStyles.black14inter400.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
