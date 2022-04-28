// ignore: prefer_double_quotes
import 'package:flutter/material.dart';
import 'package:flutter_test_application/styles/app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.grey,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.blue,
  ),
);
