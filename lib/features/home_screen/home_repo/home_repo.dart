import 'dart:developer';
import 'package:meals_app/core/data/local_data_base/model/local_meal_model.dart';

import '../../../core/data/local_data_base/db_helper/db_helper.dart';
import '../../../core/data/network/api_endpoints.dart';
import '../../../core/data/network/dio_helper.dart';
import '../../../core/data/network/model/api_meal_model.dart';
import '../../../core/data/network/model/categories_model.dart';
import '../../../core/domain/mapper.dart';
import '../../../core/domain/models/meal_model.dart';


class HomeRepo {

  Future<CategoriesModel?> getMealsCategory() async {
    final response = await DioHelper.getRequest(
      endPoint: ApiEndpoints.listOfCategory,
      query: {
       "c" : "list"

      },
    );

    if (response == null || response.data == null) {
      return null;
    }

    try {
      return CategoriesModel.fromJson(response.data);
    } catch (e) {
      log(response.data.toString());
      return null;
    }
  }

  Future<List<Meal>> getMealsByFilter(
      String c
      ) async {
    final response = await DioHelper.getRequest(
      endPoint: ApiEndpoints.filterBy,
      query: {"c" : c },
    );

    if (response == null || response.data == null) {
      return [];
    }
    try {
      final apiModel = ApiMealsModel.fromJson(response.data);

      return apiModel.meals
          .map((apiMeal) => MealMapper.fromApi(apiMeal))
          .toList();

    } catch (e) {
      log(response.data.toString());
      return [];
    }
  }

  Future<Meal?> getMealDetails(String? id) async {
    final response = await DioHelper.getRequest(
      endPoint: ApiEndpoints.searchById,
      query: {"i": id},
    );

    if (response?.data == null) return null;

    final meals = response!.data['meals'] as List?;

    if (meals == null || meals.isEmpty) return null;

    return MealMapper.fromApi(ApiMeal.fromJson(meals.first));
  }

  // ------------- local Database methods ------------------

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

  Future getMealsFromLocalDb()async{
    final DataBaseHelper dbHelper = DataBaseHelper.instance;

    final List<LocalMeal> meals = await dbHelper.getMeals();

    return meals.map((e) => LocalMealMapper.fromLocal(e)).toList();
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