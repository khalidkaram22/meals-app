import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/data/local_data_base/db_helper/db_helper.dart';
import '../../core/data/local_data_base/model/local_meal_model.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_styles.dart';
import '../../core/widgets/app_snack_bar_widget.dart';
import '../../core/widgets/custom_text_field_widget.dart';
import '../../core/widgets/top_screens_header.dart';

class AddMealsScreen extends StatefulWidget {
  const AddMealsScreen({super.key});

  @override
  State<AddMealsScreen> createState() => _AddMealsScreen();
}

class _AddMealsScreen extends State<AddMealsScreen> {
  final _formKey = GlobalKey<FormState>();

  final foodNameController = TextEditingController();
  final foodImageUrlController = TextEditingController();
  final foodRateController = TextEditingController();
  final foodTimeController = TextEditingController();
  final foodInstructionsController = TextEditingController();

  DataBaseHelper dbHelper = DataBaseHelper.instance;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: isLoading == true
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
                  child: Center(
                        child: SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: CircularProgressIndicator(
                            color: AppColors.orange,
                          ),
                        ),

                    ),
                )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18.h),

                      TopScreensHeader(screenHeader: "Add Meal"),

                      Text("Meal Name", style: AppStyles.black14inter400),
                      CustomTextFieldWidget(
                        hintText: "BreakFast",
                        controller: foodTimeController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            AppSnackBarWidget(
                              snackBarText: "please enter the meal name",
                            );

                            return "please enter the meal name ";
                          }

                          return null;
                        },
                      ),

                      Text("Image URL", style: AppStyles.black14inter400),
                      CustomTextFieldWidget(
                        maxLines: 3,
                        controller: foodImageUrlController,
                        hintText:
                            "https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg",

                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            AppSnackBarWidget(
                              snackBarText: "please enter the meal name",
                            );

                            return "please enter the meal name ";
                          }

                          return null;
                        },
                      ),

                      Text("Rate", style: AppStyles.black14inter400),
                      CustomTextFieldWidget(
                        hintText: "4.6",
                        controller: foodRateController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),

                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            AppSnackBarWidget(
                              snackBarText: "please enter the meal name",
                            );

                            return "please enter the meal name ";
                          }

                          return null;
                        },
                      ),

                      Text("Time", style: AppStyles.black14inter400),
                      CustomTextFieldWidget(
                        hintText: "10-30",
                        controller: foodTimeController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "please enter the meal name";
                          }
                          return null;
                        },
                      ),

                      Text("description", style: AppStyles.black14inter400),
                      CustomTextFieldWidget(
                        hintText:
                            "first "
                            "second",

                        maxLines: 5,
                        controller: foodInstructionsController,
                        // height: 116.h,
                        validator: (val) {
                          if (val == null || val.isEmpty)  {
                            AppSnackBarWidget(
                              snackBarText: "please enter the meal name",
                            );

                            return "please enter the meal name ";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 32.h),

                      ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {

                            setState(() {
                              isLoading = true ;
                            });

                            var uuid = Uuid();
                            LocalMeal meal = LocalMeal(
                              id: uuid.v4(), // "random-id"
                              name: foodNameController.text,
                              imageUrl: foodImageUrlController.text,
                              time: foodTimeController.text,
                              instructions: foodInstructionsController.text,
                              rate: double.parse(foodRateController.text),
                              source: 'local',
                            );

                            await dbHelper.insertMeal(meal);

                            if (!context.mounted) return;



                            if (!mounted) return;

                            setState(() {
                              isLoading = false;
                            });

                            SnackBar(content: Text("save done"),);
                            isLoading = false ;
                            context.pop(true);
                            // context.push(AppRoutes.myMealScreen);

                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          fixedSize: Size(327.h, 52.h),
                        ),
                        child: Text(
                          "Save",
                          style: AppStyles.white400Inter14.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
