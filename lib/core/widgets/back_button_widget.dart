import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../styles/app_colors.dart';

class BackButtonWidget extends StatelessWidget {

  final Color? iconColor ;
  final Color? borderColor ;
  final int? bgColorOPacity ;


  const BackButtonWidget({super.key, this.iconColor, this.borderColor, this.bgColorOPacity});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      color: AppColors.white.withAlpha(bgColorOPacity ?? 255),

      child: InkWell(
        onTap: () {
          if (context.canPop()) {
            context.pop(true);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Data saved successfully"),
              ),
            );
          }
        },
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(bgColorOPacity?? 255),
              shape: BoxShape.circle,
              border: Border.all(color:borderColor ?? Color(0xffE8ECF4), width: 1),
            ),
            child: Center(
              child: Icon(color: iconColor ?? AppColors.black, Icons.arrow_back_ios_new_rounded ,
              size: 20.sp,
              ),
            ),
          ),
      ),
    );
  }
}
