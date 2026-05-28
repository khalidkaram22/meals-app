import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meals_app/core/domain/models/meal_model.dart';
import 'package:meals_app/features/home_screen/home_screen.dart';
import 'package:meals_app/features/main_scaffold_screen/main_shell.dart';
import 'package:meals_app/features/search_result_screen/repo/search_repo.dart';
import 'package:meals_app/features/search_result_screen/search_cubit/search_cubit.dart';
import '../../features/add_meals_screen/add_meals_screen.dart';
import '../../features/meal_detials_screen/meal_detials_screen.dart';
import '../../features/my_meals/my_meals_screen.dart';
import '../../features/on_boarding/on_boarding_screen.dart';
import '../../features/on_boarding/on_boarding_service/on_boarding_services.dart';
import '../../features/search_result_screen/screen_result_screen.dart';
import 'app_routes.dart';

class RouterGenerationConfig {
  static final GoRouter goRouter = GoRouter(
    initialLocation: OnBoardingServices().isFirstTime()
        ? AppRoutes.onBoardingScreen
        : AppRoutes.homeScreen,

    routes: [
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        builder: (context, state) => const OnBoardingScreen(),
      ),

      GoRoute(
        path: AppRoutes.mealDetailsScreen,
        builder: (context, state) {
          final Meal meal = state.extra as Meal;
          return MealDetialsScreen(meal: meal);
        },
      ),

      GoRoute(
        path: AppRoutes.searchResultScreen,

        builder: (context, state) {
          final query = state.extra;
          return BlocProvider(
            create: (context) =>
                SearchCubit(SearchRepo()),
            child: SearchResultScreen(query: query.toString(),),
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: AppRoutes.homeScreen,
                  builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.addMealsScreen,
                builder: (context, state) => const AddMealsScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myMealScreen,
                builder: (context, state) => const MyMealsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
