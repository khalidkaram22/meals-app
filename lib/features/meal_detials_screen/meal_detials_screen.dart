import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meals_app/core/styles/app_colors.dart';
import 'package:meals_app/core/widgets/back_button_widget.dart';
import 'package:meals_app/features/home_screen/home_cubit/home_cubit.dart';
import 'package:meals_app/features/meal_detials_screen/widgets/menu_button_widget.dart';
import 'package:meals_app/features/my_meals/my_meals_cubit/my_meals_cubit.dart';
import '../../core/domain/models/meal_model.dart';
import '../../core/styles/app_styles.dart';

class MealDetialsScreen extends StatelessWidget {
  final Meal meal;

  const MealDetialsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    // final bool isSaved = meal.isFavorite;
    final isSaved = context.watch<HomeCubit>().isSavedMeal(meal.id);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8.h),

              Stack(
                children: [
                  Container(
                    height: 327.h,
                    width: 359.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: meal.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/Image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Container(
                    height: 327.h,
                    width: 359.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.black.withAlpha(100),
                    ),
                  ),

                  Positioned(
                    top: 17.h,
                    left: 12.w,
                    child: BackButtonWidget(
                      bgColorOPacity: 0,
                      iconColor: AppColors.white,
                      borderColor: AppColors.white,
                    ),
                  ),

                  MenuButtonWidget(

                    onEdit: () async {
                      if (isSaved) {
                        await context.read<HomeCubit>().updateMeal(meal);
                        if (context.mounted) {
                          context.read<MyMealsCubit>().getMeals();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Save meal first")),
                        );
                      }
                    },

                    onDelete: () async {
                      if (isSaved) {
                        await context.read<HomeCubit>().deleteMeal(meal.id);
                        if (context.mounted) {
                          context.read<MyMealsCubit>().getMeals();
                          context.pop();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Removed from favorites 💔")),
                        );
                      }
                    },

                    onAdd: () async {
                      if (isSaved) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Meal is already saved"),
                          ),
                        );
                      } else if (!isSaved){
                        await context.read<HomeCubit>().addToFavorites(meal);
                        if (context.mounted) {
                          context.read<MyMealsCubit>().getMeals();
                        }
                        const SnackBar(
                          content: Text("Added to favorites ❤️"),
                        );
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        meal.name,
                        style: AppStyles.black14inter400.copyWith(
                          fontSize: 32.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 21.h),

                    Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withAlpha(12),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.r),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later,
                                color: AppColors.orange,
                                size: 16.sp,
                              ),

                              SizedBox(width: 4.h),

                              Text(
                                "null",
                                style: AppStyles.black14inter400.copyWith(
                                  color: AppColors.grey2,
                                ),
                              ),
                            ],
                          ),

                          // SizedBox(width: 35.w,),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.orange,
                                size: 16.sp,
                              ),

                              SizedBox(width: 4.w),

                              Text(
                                "${meal.rating}",
                                style: AppStyles.black14inter400.copyWith(
                                  color: AppColors.grey2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 27.h),

                    Divider(color: Color(0xffEDEDED)),

                    SizedBox(height: 24.h),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "instructions",
                        style: AppStyles.black16inter600,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        meal.instructions ??
                            "meal Description meal Description meal Description meal Description ",
                        style: AppStyles.black14inter400.copyWith(
                          color: AppColors.grey2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
