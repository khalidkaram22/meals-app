class Meal {
  final String id;
  final String name;
  final String imageUrl;

  final String? category;
  final String? area;
  final String? instructions;

  final bool isFavorite;
  final double rating;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category,
    this.area,
    this.instructions,
    this.isFavorite = false,
    this.rating = 4.0,
  });
}