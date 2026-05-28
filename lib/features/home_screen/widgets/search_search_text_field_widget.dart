import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/styles/app_colors.dart';
import 'custom_search_text_field_widget.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final VoidCallback? onPress;

  const SearchTextFieldWidget({super.key, this.onPress});

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  // bool showTextField = true;

  void toggleSearch() {
    isSearchVisible = !isSearchVisible;
  }

  bool isSearchVisible = true;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool textFieldIsEmpty = controller.text.isEmpty;

    return Row(
      children: [
        CustomSearchTextFieldWidget(
          width: 320.w,
          suffixIcon: IconButton(
            icon: Icon(Icons.close_rounded, color: AppColors.grey2),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                controller.text = "";
              }
            },
          ),

          prefixIcon: IconButton(
            icon: Icon(Icons.search_rounded, color: AppColors.creme),
            onPressed: () {
              setState(() {
                if (controller.text.isNotEmpty) {
                  context.push(
                    AppRoutes.searchResultScreen,
                    extra: controller.text,
                  );
                } else {
                  Text("search is empty");
                }
              });
            },
          ),
          hintTextField: "search",
          controller: controller,
        ),
      ],
    );
  }
}
