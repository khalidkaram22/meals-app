import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/data/network/model/categories_model.dart';
import 'category_button_item.dart';

class ScrollRowCategoryCarouselWidget extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const ScrollRowCategoryCarouselWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          final isSelected = selectedCategory == category.name;

          return CategoryButtonItem(
            title: category.name,
            isSelected: isSelected,
            onPress: () {
              onCategorySelected(category.name);
            },
          );
        },
      ),
    );
  }
}