import 'dart:developer';
import 'package:meals_app/core/data/network/model/api_meal_model.dart';
import 'package:meals_app/core/domain/mapper.dart';
import '../../../core/data/local_data_base/db_helper/db_helper.dart';
import '../../../core/data/network/api_endpoints.dart';
import '../../../core/data/network/dio_helper.dart';
import '../../../core/domain/models/meal_model.dart';

class SearchRepo {

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

  Future<List<Meal>> searchItemByName(String query) async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiEndpoints.searchByName,
        query: {
          "s": query,
        },
      );

      if (response?.statusCode == 200) {
        final apiMealsModel = ApiMealsModel.fromJson(response?.data);

        final resultMeals = (apiMealsModel.meals)
            .map((i) => MealMapper.fromApi(i))
            .toList();

        return resultMeals;
      }

      return [];

    } catch (e) {
      log(e.toString());

      return [];
    }
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

}
