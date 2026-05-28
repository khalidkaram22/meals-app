// import 'package:flutter/foundation.dart' show Category;


class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['strCategory'],
    );
  }
}


class CategoriesModel {
  final List<Category> categories;

  CategoriesModel({required this.categories});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      categories: (json['meals'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
    );
  }
}