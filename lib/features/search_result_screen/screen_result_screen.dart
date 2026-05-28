import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meals_app/core/domain/models/meal_model.dart';
import 'package:meals_app/features/my_meals/my_meals_cubit/my_meals_cubit.dart';
import 'package:meals_app/features/search_result_screen/repo/search_repo.dart';
import 'package:meals_app/features/search_result_screen/search_cubit/search_cubit.dart';
import 'package:meals_app/features/search_result_screen/search_cubit/search_state.dart';
import '../../core/route/app_routes.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_styles.dart';
import '../home_screen/home_cubit/home_cubit.dart';
import '../home_screen/widgets/home_food_item_card_widget.dart';

class SearchResultScreen extends StatefulWidget {
  final String? query;
  const SearchResultScreen({super.key,
    this.query
  });

  @override
  State<StatefulWidget> createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {

  bool isLoadingDetails = false;

  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().fetchMealsByNameSearch(widget.query ?? "");
  }

  void addMealsToDb(Meal meal) async {

    final repo = context.read<SearchCubit>().searchRepo;
    final mealDetails = await repo.getMealDetails(meal.id);

    await repo.addMealToDb(mealDetails ?? meal);

    if (mounted) {
      await context.read<HomeCubit>().loadHome();
      if (mounted) {
        context.read<MyMealsCubit>().getMeals();
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Added to favorites ❤️")));

  }

  Future<void> showMealDetails(Meal meal) async {
    if (isLoadingDetails) return;

    setState(() {
      isLoadingDetails = true;
    });

    try {
      final mealDetails = await SearchRepo().getMealDetails(meal.id);

      if (mealDetails == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("No meal details found")));
        return;
      }

      if (!context.mounted) return;

      context.push(AppRoutes.mealDetailsScreen, extra: mealDetails);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoadingDetails = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Text(
            "search_result", style: AppStyles.black14inter400.copyWith(
              fontSize: 18.sp
          ), textAlign: TextAlign.center,),
        ),

        toolbarHeight: 120.h,

        actions: [
        ],

        backgroundColor: AppColors.grey,
      ),

      body: BlocBuilder<SearchCubit, SearchState > (
    builder: (context, state) {
      if (state is LoadSearchState) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is ErrorSearchState) {
        return Center(child: Text(state.error.toString()));
      }

      if (state is SuccessSearchState) {
        final meals = state.meals;

        if (meals.isEmpty) {
          return const Center(child: Text("No meals found"));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];

            return HomeFoodItemCardWidget(
              isSaved: false,
              addTOfav: () {
                addMealsToDb(meal);
              },
              meal: meal,
              category: meal.category ?? "",
              onTap: () {
                showMealDetails(meal);
              },
            );
          },
        );
      }

      return const Center(child: Text("Search for meals"));
    },
    ),
    );
  }

}
