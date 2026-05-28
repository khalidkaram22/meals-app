import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppStyles {

  static TextStyle white600Inter32 = TextStyle(
    fontFamily: AppFonts.interFontRegular,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );


  static TextStyle white400Inter14 = TextStyle(
    fontFamily: AppFonts.interFontRegular,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );


  static TextStyle black16inter600 = TextStyle(
    fontFamily: AppFonts.interFontRegular,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle black16inter500 = TextStyle(
    fontFamily: AppFonts.interFontRegular,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle black14inter400 = TextStyle(
    fontFamily: AppFonts.interFontRegular,
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );


  static Icon styledIcon(
    IconData iconData, {
    Color color = Colors.blue,
    double size = 24,
  }) {
    return Icon(iconData, color: color, size: size);
  }
}
