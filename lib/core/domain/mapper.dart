import '../data/local_data_base/model/local_meal_model.dart';
import '../data/network/model/api_meal_model.dart';
import 'models/meal_model.dart';




class MealMapper {
  static Meal fromApi(ApiMeal apiMeal) {
    return Meal(
      id: apiMeal.id,
      name: apiMeal.name,
      imageUrl: apiMeal.thumbnail,
      category: apiMeal.category,
      area: apiMeal.area,
      instructions: apiMeal.instructions,
      rating:4.0,
    );
  }
}


class MealToLocalMapper {
  static LocalMeal toLocal(Meal meal) {
    return LocalMeal(
      id: meal.id,
      name: meal.name,
      imageUrl: meal.imageUrl,
      time: "", // or calculated
      instructions: meal.instructions ?? "",
      rate: meal.rating,
      source: "api",
    );
  }
}



class LocalMealMapper {
  static Meal fromLocal(LocalMeal localMeal) {
    return Meal(
      id: localMeal.id,
      name: localMeal.name,
      imageUrl: localMeal.imageUrl,
      instructions: localMeal.instructions,
      rating: localMeal.rate,
      isFavorite: true,
    );
  }
}