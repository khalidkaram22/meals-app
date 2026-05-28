import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/route/app_routes.dart';
import '../../core/styles/app_assets.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_styles.dart';
import '../home_screen/home_cubit/home_cubit.dart';
import '../meal_detials_screen/widgets/menu_button_widget.dart';
import 'my_meals_cubit/my_meals_cubit.dart';
import 'my_meals_cubit/my_meals_state.dart';
import 'widgets/food_item_card.dart';


class MyMealsScreen extends StatefulWidget {
  const MyMealsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyMealsScreen();
}

class _MyMealsScreen extends State<MyMealsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<MyMealsCubit>().getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: double.infinity,
            height: 229.h,
            padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 8.h),

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.homeScreenImage),
                fit: BoxFit.fill,
              ),
            ),

            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 8.w),

                alignment: Alignment.center,
                width: 180.2.w,
                height: 186.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48.r),
                  color: AppColors.orange.withAlpha(32),
                ),

                child: Text(
                  "Welcome\nAdd A New Recipe",
                  style: AppStyles.white600Inter32,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.5.w, vertical: 25.h),
            child: Text(
              textAlign: TextAlign.start,
              "Your Food",
              style: AppStyles.black16inter600,
            ),
          ),

          Expanded(
            child: BlocBuilder<MyMealsCubit, MyMealsState>(
              builder: (context, state) {

                if (state is MyMealsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppStyles.black14inter400,
                    ),
                  );
                }

                if (state is MyMealsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                }

                if (state is MyMealsLoaded) {
                  final meals = state.meals;

                  if (meals.isEmpty) {
                    return Center(
                      child: Text(
                        "No meals in the database",
                        style: AppStyles.black14inter400,
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GridView.builder(
                      itemCount: meals.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.sp,
                        mainAxisSpacing: 22.sp,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        final isSaved = context.watch<HomeCubit>().isSavedMeal(meal.id);


                        return Stack(
                          children: [

                            FoodItemCard(
                              name: meal.name,
                              imageUrl: meal.imageUrl,
                              rate: meal.rating,
                              onTap: () {
                                context.push(
                                  AppRoutes.mealDetailsScreen,
                                  extra: meal,
                                );
                              },
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
                              haveAdd: false,
                            ),

                          ],
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.darkOrange,
        shape: CircleBorder(),
        onPressed: () async {
          final result = await context.push(AppRoutes.addMealsScreen);
          if (result == true && mounted) {
            context.read<MyMealsCubit>().getMeals();
          }
        },
        child: Icon(
          Icons.add_rounded,
          color: AppColors.white,
          size: 32.sp,
        ),
      ),
    );
  }
}
