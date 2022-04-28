// ignore: prefer_double_quotes
import 'package:flutter/material.dart';
import "package:flutter_test_application/styles/app_colors.dart";

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.grey,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.blue,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    isDense: true,
    isCollapsed: true,
    hintStyle: const TextStyle(
      color: AppColors.containerColor,
    ),
    labelStyle: const TextStyle(color: AppColors.containerColor),
    fillColor: AppColors.blue,
    focusColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.containerColor),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.containerColor),
      borderRadius: BorderRadius.circular(8),
    ),
    errorStyle: const TextStyle(color: AppColors.containerColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    disabledBorder: InputBorder.none,
  ),
);
