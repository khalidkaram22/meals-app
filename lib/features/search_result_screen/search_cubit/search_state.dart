
import 'package:meals_app/core/domain/models/meal_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class LoadSearchState extends SearchState {}

class SuccessSearchState extends SearchState {
  final List<Meal> meals;
  SuccessSearchState(this.meals);
}

class ErrorSearchState extends SearchState {
  final String error;
  ErrorSearchState(this.error);
}