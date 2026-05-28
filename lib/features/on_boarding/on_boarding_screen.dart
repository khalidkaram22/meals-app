import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meals_app/core/route/app_routes.dart';
import 'package:meals_app/core/styles/app_assets.dart';
import 'package:meals_app/core/styles/app_colors.dart';
import 'package:meals_app/core/styles/app_styles.dart';
import 'package:meals_app/features/on_boarding/on_boarding_service/on_boarding_services.dart';
import 'widget/index_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  static const int length = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.onBoardingBackgroundImg),
            fit: BoxFit.fill,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 372.h),

            Container(
              height: 400.h,
              width: 311.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.orange.withAlpha(220),
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),

                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 252.w,
                      height: 120.h,

                      child: Text(
                        AppAssets.onboardingData[index]["title"]!,
                        style: AppStyles.white600Inter32,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      AppAssets.onboardingData[index]["body"]!,
                      style: AppStyles.white400Inter14,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 36.h),

                    IndexWidget(index: index, length: length),

                    index < 2 ?SizedBox(height: 98.h) : SizedBox(height: 40.h),

                    index < 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    OnBoardingServices().setFirstTimeWithFalse();
                                   context.go(AppRoutes.homeScreen);
                                  });
                                },
                                child: Text(
                                  "Skip",
                                  style: AppStyles.white400Inter14,
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (index < length - 1) {
                                      index++;
                                    }
                                  });
                                },
                                child: Text(
                                  "Next",
                                  style: AppStyles.white400Inter14,
                                ),
                              ),
                            ],
                          )
                        : Container(
                            width: 62.w,
                            height: 62.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  OnBoardingServices().setFirstTimeWithFalse();
                                  context.go(AppRoutes.homeScreen);
                                });
                              },
                              child: Icon(
                                Icons.arrow_forward,
                              size: 24.sp,
                              color: AppColors.orange,),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
