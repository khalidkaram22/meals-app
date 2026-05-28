import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/styles/app_styles.dart';

import '../styles/app_colors.dart';
import 'back_button_widget.dart';

class TopScreensHeader extends StatefulWidget{

  final String? screenHeader ;
  final IconData? rightIc ;
  final Color? iconColor ;

  const TopScreensHeader({super.key,  this.rightIc, this.screenHeader, this.iconColor});

  @override
  State<TopScreensHeader> createState() => _TopScreensHeaderState();
}

class _TopScreensHeaderState extends State<TopScreensHeader> {
  @override
  Widget build(BuildContext context) {

    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButtonWidget(),
        Text(
          widget.screenHeader ?? "All Card",
          style: AppStyles.black16inter600 ,

        ),

        Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(

                shape: BoxShape.circle,
                border: Border.all(color: Color(0xffF2F2F5))

            ),
            child: Icon(widget.rightIc??Icons.more_horiz_outlined ,
              size: 30.sp,
              color: widget.iconColor ?? AppColors.black,
            )),

      ],
    )
    ;

  }
}
