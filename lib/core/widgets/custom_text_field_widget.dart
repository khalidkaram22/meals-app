import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final double? width;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  const CustomTextFieldWidget(
      {super.key,
        this.hintText,
        this.suffixIcon,
        this.width,
        this.isPassword,
        this.controller,
        this.keyboardType,
        this.validator,
        this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? 331.w,
        child: TextFormField(
            controller: controller,
            validator: validator,
            autofocus: false,
            maxLines: maxLines ?? 1,
            obscureText: isPassword ?? false,
            cursorColor: AppColors.orange,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xff8391A1),
                  fontWeight: FontWeight.w500),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Color(0xffE8ECF4), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                      color: AppColors.orange, width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.red, width: 1)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: suffixIcon,
            )));
  }
}