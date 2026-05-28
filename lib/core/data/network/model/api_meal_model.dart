
class ApiMeal {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final String category;
  final String area;

  ApiMeal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.category,
    required this.area,
  });

  factory ApiMeal.fromJson(Map<String, dynamic> json) {
    return ApiMeal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      instructions: json['strInstructions'] ?? "",
      category: json['strCategory'] ?? "",
      area: json['strArea'] ?? "",
    );
  }
}
class ApiMealsModel {
  final List<ApiMeal> meals;

  ApiMealsModel({required this.meals});

  factory ApiMealsModel.fromJson(Map<String, dynamic> json) {
    final list = json['meals'] as List? ?? [];

    return ApiMealsModel(
      meals: list.map((e) => ApiMeal.fromJson(e)).toList(),
    );
  }
}


