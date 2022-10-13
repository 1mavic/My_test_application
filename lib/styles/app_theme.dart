import "package:flutter/material.dart";
import "package:my_app/styles/app_colors.dart";

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.grey,
  cardColor: AppColors.containerColor,
  dialogBackgroundColor: AppColors.white,
  primaryTextTheme: TextTheme(
    // bodyLarge: const TextStyle(
    //   color: AppColors.black,
    // ),
    bodyText1: const TextStyle(
      color: AppColors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColors.white, //change your color here
    ),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    backgroundColor: AppColors.blue,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    isDense: true,
    isCollapsed: true,
    hintStyle: const TextStyle(
      color: AppColors.blue,
    ),
    labelStyle: const TextStyle(color: AppColors.containerColor),
    fillColor: AppColors.containerColor,
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
    errorStyle: const TextStyle(color: AppColors.red),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    disabledBorder: InputBorder.none,
  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.black,
  cardColor: AppColors.containerColorDark,
  dialogBackgroundColor: AppColors.black,
  textTheme: TextTheme(
    // bodyLarge: const TextStyle(
    //   color: AppColors.white,
    // ),
    bodyText1: const TextStyle(
      color: AppColors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColors.black, //change your color here
    ),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    backgroundColor: AppColors.gray,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    isDense: true,
    isCollapsed: true,
    hintStyle: const TextStyle(
      color: AppColors.grey,
    ),
    labelStyle: const TextStyle(color: AppColors.containerColorDark),
    fillColor: AppColors.containerColorDark,
    focusColor: AppColors.gray,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.containerColorDark),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.containerColorDark),
      borderRadius: BorderRadius.circular(8),
    ),
    errorStyle: const TextStyle(color: AppColors.red),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    disabledBorder: InputBorder.none,
  ),
);
