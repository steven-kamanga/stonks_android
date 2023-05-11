import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColor: ColorManager.white,
    primaryColorDark: ColorManager.black,
    disabledColor: ColorManager.gray,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.black),
    //card view theme
    splashColor: ColorManager.white,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.black,
      elevation: AppSize.s4,
    ),
    //appbar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.white,
      centerTitle: true,
      elevation: AppSize.s0,
      shadowColor: ColorManager.white,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),

    //inputdecoration theme(textformfield)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManager.black,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.black,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.red,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.black,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.black,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.red,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}
