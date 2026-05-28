import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data/network/model/categories_model.dart';
import '../../../core/domain/models/meal_model.dart';
import '../home_repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitial());

  String selectedCategory = "Beef";

  Future<void> loadHome() async {
    emit(HomeLoading());

    try {
      final CategoriesModel? categoriesResponse = await repo.getMealsCategory();

      final List<Meal> meals = await repo.getMealsByFilter(selectedCategory);

      final List<Meal> localMeals = await repo.getMealsFromLocalDb();


      emit(
        HomeLoaded(
          categories: categoriesResponse?.categories ?? [],
          meals: meals,
          selectedCategory: selectedCategory,
          localMeals: localMeals,
        ),
      );
    } catch (e) {
      emit(HomeError("Failed to load data"));
    }
  }

  Future<void> changeCategory(String category) async {
    final currentState = state;

    if (currentState is HomeLoaded) {
      selectedCategory = category;

      emit(currentState.copyWith(isLoading: true, selectedCategory: category));

      try {
        final meals = await repo.getMealsByFilter(category);

        emit(
          currentState.copyWith(
            meals: meals,
            isLoading: false,
            selectedCategory: category,
          ),
        );
      } catch (e) {
        emit(HomeError("Failed to load meals"));
      }
    }
  }

  Future<void> addToFavorites(Meal meal) async {
    final currentState = state;

    if (currentState is HomeLoaded) {

      if (isSavedMeal(meal.id)) {
        deleteMeal(meal.id);
        return;
      }

      final mealDetails = await repo.getMealDetails(meal.id);
      final savedMeal = mealDetails ?? meal;

      await repo.addMealToDb(savedMeal);

      final updatedLocalMeals = List<Meal>.from(currentState.localMeals);
      updatedLocalMeals.add(savedMeal);

      emit(currentState.copyWith(localMeals: updatedLocalMeals));
    }
  }

  Future<Meal?> getMealDetails(Meal meal) async {
    return await repo.getMealDetails(meal.id);
  }

  bool isSavedMeal(String mealId) {
    final currentState = state;

    if (currentState is HomeLoaded) {
      return currentState.localMeals
          .any((meal) => meal.id == mealId);
    }

    return false;
  }

  Future<void> updateMeal(Meal meal) async {
    final currentState = state;

    if (currentState is HomeLoaded) {
      await repo.updateMealInDb(meal);

      final updatedList = currentState.localMeals.map((m) {
        return m.id == meal.id ? meal : m;
      }).toList();

      emit(currentState.copyWith(localMeals: updatedList));
    }
  }


  Future<void> deleteMeal(String id) async {
    final currentState = state;

    if (currentState is HomeLoaded) {
      await repo.deleteMealFromDb(id);

      final updatedList = currentState.localMeals
          .where((meal) => meal.id != id)
          .toList();

      emit(currentState.copyWith(localMeals: updatedList));
    }
  }


}
