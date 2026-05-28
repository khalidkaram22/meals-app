import 'dart:developer';

import 'package:meals_app/core/data/local_data_base/db_helper/db_helper.dart';
import 'package:meals_app/core/data/local_data_base/model/local_meal_model.dart';

import '../../../core/domain/mapper.dart';
import '../../../core/domain/models/meal_model.dart';

class MyMealsRepo {
  Future<List<Meal>> getMealsFromDb() async {
    final DataBaseHelper dbHelper = DataBaseHelper.instance;

    final List<LocalMeal> meals = await dbHelper.getMeals();

    return meals
        .map((m) => LocalMealMapper.fromLocal(m))
        .toList();
  }

  Future<void> addMealToDb(Meal meal) async {
    try {
      final dbHelper = DataBaseHelper.instance;
      final localMeal = MealToLocalMapper.toLocal(meal);

      await dbHelper.insertMeal(localMeal);

      log("Inserted: ${meal.name}");
    } catch (e) {
      log("Error inserting meal: $e");
    }
  }

  Future<void> updateMealInDb(Meal meal) async {
    final dbHelper = DataBaseHelper.instance;

    final localMeal = MealToLocalMapper.toLocal(meal);

    await dbHelper.updateMeal(localMeal);
  }

  Future<void> deleteMealFromDb(String id) async {
    final dbHelper = DataBaseHelper.instance;
    await dbHelper.deleteMeal(id);
  }


}
