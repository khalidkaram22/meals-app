import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:meals_app/core/route/app_routes.dart';
import 'package:meals_app/core/styles/app_colors.dart';
import 'package:meals_app/core/styles/app_styles.dart';

import 'package:meals_app/features/home_screen/widgets/categories_row_list_widget.dart';
import 'package:meals_app/features/home_screen/widgets/home_food_item_card_widget.dart';
import 'package:meals_app/features/home_screen/widgets/search_search_text_field_widget.dart';
import 'package:meals_app/features/my_meals/my_meals_cubit/my_meals_cubit.dart';

import 'home_cubit/home_cubit.dart';
import 'home_cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          actionsPadding: EdgeInsets.symmetric(horizontal: 24.w),
          toolbarHeight: 100.h,
          backgroundColor: AppColors.white,
          actions: const [SearchTextFieldWidget()],
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              Text(
                "Trending",
                style: AppStyles.black16inter600.copyWith(fontSize: 24.sp),
              ),

              SizedBox(height: 8.h),

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is HomeLoaded) {
                      return Column(
                        children: [
                          ScrollRowCategoryCarouselWidget(
                            selectedCategory: state.selectedCategory,
                            categories: state.categories,
                            onCategorySelected: (category) {
                              context.read<HomeCubit>().changeCategory(
                                category,
                              );
                            },
                          ),

                          SizedBox(height: 24.h),

                          Expanded(
                            child: ListView.builder(
                              itemCount: state.meals.length,
                              itemBuilder: (context, index) {
                                final meal = state.meals[index];
                                var isSaved = context
                                    .read<HomeCubit>()
                                    .isSavedMeal(meal.id);

                                return HomeFoodItemCardWidget(
                                  isSaved: isSaved,
                                  meal: meal,
                                  category: state.selectedCategory,

                                  addTOfav: () async {
                                    final messenger = ScaffoldMessenger.of(context);

                                    await context.read<HomeCubit>().addToFavorites(
                                      meal,
                                    );

                                    if (context.mounted) {
                                      context.read<MyMealsCubit>().getMeals();
                                    }

                                    messenger.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isSaved
                                              ? "Removed from favorites  💔"
                                              : "Added to favorites ❤️",
                                        ),
                                      ),
                                    );
                                  },
                                  onTap: () async {
                                    final details = await context
                                        .read<HomeCubit>()
                                        .getMealDetails(meal);

                                    if (details != null && context.mounted) {
                                      context.push(
                                        AppRoutes.mealDetailsScreen,
                                        extra:meal,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),

        /// Floating Button
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: AppColors.darkOrange,
          shape: const CircleBorder(),
          onPressed: () => context.push(AppRoutes.addMealsScreen),
          child: Icon(Icons.add_rounded, color: AppColors.white, size: 32.sp),
        ),
    );
  }
}
