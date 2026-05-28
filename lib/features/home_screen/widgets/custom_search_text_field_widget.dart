import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_fonts.dart';
import 'package:flutter/services.dart';


class CustomSearchTextFieldWidget extends StatelessWidget {
  final String? hintTextField;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final double? width;
  final double? height;
  final bool? isPassword;
  final TextInputType? keyboardType;

  final int? maxLines;

  final String? Function(String?)? validator;

  final TextEditingController? controller;

  const CustomSearchTextFieldWidget({
    super.key,
    this.hintTextField,
    this.suffixIcon,
    this.width,
    this.height,
    this.isPassword,
    this.validator,
    this.controller,
    this.keyboardType,
    this.maxLines, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 331.w,
      height: height ?? 56.h,

      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,

        maxLines: maxLines ?? 1,
        obscureText: isPassword ?? false,
        autofocus: false,
        cursorColor: AppColors.orange,
        decoration: InputDecoration(
          hintText: hintTextField ?? "",

          hintStyle: TextStyle(
            fontFamily: AppFonts.interFontRegular,
            color: AppColors.grey2,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.r),
            borderSide: BorderSide(color: AppColors.grey, width: 1.w),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.r),
            borderSide: BorderSide(color: AppColors.orange, width: 1.w),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),

          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 18.h,
          ),
          filled: true,
          fillColor: AppColors.lightGrey,
          focusColor: AppColors.white,


          suffixIcon: suffixIcon,

          prefixIcon: prefixIcon,

        ),
      ),
    );
  }
}





