import '../../../core/domain/models/meal_model.dart';

abstract class MyMealsState {}

class MyMealsInitial extends MyMealsState {}

class MyMealsLoading extends MyMealsState {}

class MyMealsLoaded extends MyMealsState {
  final List<Meal> meals;

  MyMealsLoaded(this.meals);

  MyMealsLoaded copyWith({
    List<Meal>? meals,
  }) {
    return MyMealsLoaded(
      meals ?? this.meals,
    );
  }
}



class MyMealsError extends MyMealsState {
  final String message;

  MyMealsError(this.message);
}