// my_meals_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/features/my_meals/my_meals_repo/my_meals_repo.dart';
import '../../../core/domain/models/meal_model.dart';
import 'my_meals_state.dart';

class MyMealsCubit extends Cubit<MyMealsState> {
  final MyMealsRepo myMealsRepo;


  MyMealsCubit(this.myMealsRepo) : super(MyMealsInitial());

  Future<void> getMeals() async {
    emit(MyMealsLoading());

    try {
      final meals = await myMealsRepo.getMealsFromDb();
      emit(MyMealsLoaded(meals));
    } catch (e) {
      emit(MyMealsError(e.toString()));
    }
  }


  Future<void> updateMeal(Meal meal) async {
    final currentState = state;

    if (currentState is MyMealsLoaded) {
      await myMealsRepo.updateMealInDb(meal);

      final updatedList = currentState.meals.map((m) {
        return m.id == meal.id ? meal : m;
      }).toList();

      emit(currentState.copyWith(meals: updatedList));
    }
  }


  Future<void> deleteMeal(String id) async {
    final currentState = state;

    if (currentState is MyMealsLoaded) {
      try {
        await myMealsRepo.deleteMealFromDb(id);

        final updatedList = currentState.meals
            .where((meal) => meal.id != id)
            .toList();

        emit(currentState.copyWith(meals: updatedList));
      } catch (e) {
        emit(MyMealsError(e.toString()));
      }
    }
  }


  bool isSavedMeal(String mealId) {
    final currentState = state;

    if (currentState is MyMealsLoaded) {
      return currentState.meals
          .any((meal) => meal.id == mealId);
    }

    return false;
  }


}