import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/app_styles.dart';

class AppSnackBarWidget extends StatelessWidget{

  final String? snackBarText ;



  const AppSnackBarWidget({super.key,this.snackBarText});

  @override
  Widget build(BuildContext context) {

    return SnackBar(
      content: Text(snackBarText ?? "please enter the textField",
        style: AppStyles.white400Inter14,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: AppColors.orange,
    );

  }
}