import 'package:meals_app/core/data/network/model/categories_model.dart';

import '../../../core/domain/models/meal_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Meal> meals;
  final List<Meal> localMeals;

  final String selectedCategory;
  final bool isLoading;

  HomeLoaded({
    required this.categories,
    required this.meals,
    required this.selectedCategory,
    this.isLoading = false,
    required this.localMeals,
  });

  HomeLoaded copyWith({
    List<Category>? categories,
    List<Meal>? meals,
    String? selectedCategory,
    bool? isLoading,
    List<Meal>? localMeals,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      meals: meals ?? this.meals,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      localMeals: localMeals ?? this.localMeals,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
