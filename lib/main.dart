import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/route/router_generation_config.dart';
import 'package:meals_app/features/home_screen/home_screen.dart';
import 'package:meals_app/features/on_boarding/on_boarding_screen.dart';
import 'package:meals_app/features/on_boarding/on_boarding_service/on_boarding_services.dart';
import 'core/data/network/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/features/home_screen/home_cubit/home_cubit.dart';
import 'package:meals_app/features/home_screen/home_repo/home_repo.dart';
import 'package:meals_app/features/my_meals/my_meals_cubit/my_meals_cubit.dart';
import 'package:meals_app/features/my_meals/my_meals_repo/my_meals_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OnBoardingServices.initializeSharedPreferencesStorage();

  DioHelper.initDio();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyMealsCubit(MyMealsRepo()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(HomeRepo())..loadHome(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Meals APP',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: RouterGenerationConfig.goRouter,
        );
      },
      child: OnBoardingServices().isFirstTime()
          ? OnBoardingScreen()
          : HomeScreen(),
    );
  }
}
