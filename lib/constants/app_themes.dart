import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaskai/constants/app_colors.dart';

final ThemeData kaskaiLightTheme = lightTheme();

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      brightness: Brightness.light,
      colorScheme: base.colorScheme.copyWith(
        background: AppColours.backgroundLight,
        primary: AppColours.primary,
        secondary: AppColours.secondary,
        surface: AppColours.surfaceLight,
      ),
      scaffoldBackgroundColor: AppColours.backgroundLight,
      textTheme: base.textTheme.copyWith(
        headlineLarge: const TextStyle(
          color: AppColours.foregroundLight,
          fontFamily: "GT Walsheim Pro",
        ),
        headlineMedium: const TextStyle(
          color: AppColours.foregroundLight,
          fontFamily: "GT Walsheim Pro",
        ),
        headlineSmall: const TextStyle(
          color: AppColours.foregroundLight,
          fontFamily: "GT Walsheim Pro",
        ),
        titleLarge: const TextStyle(
          color: AppColours.foregroundLight,
          // fontWeight: FontWeight.w600,
          fontFamily: "GT Walsheim Pro",
        ),
        titleMedium: const TextStyle(
          color: AppColours.foregroundLight,
          // fontWeight: FontWeight.w600,
          fontFamily: "GT Walsheim Pro",
        ),
        titleSmall: const TextStyle(
          color: AppColours.foregroundLight,
          // fontWeight: FontWeight.w600,
          fontFamily: "GT Walsheim Pro",
        ),
        bodyLarge: const TextStyle(
          color: AppColours.foregroundLight,
          fontFamily: "Inter",
          // fontWeight: FontWeight.w600,
        ),
        bodyMedium: const TextStyle(
          fontFamily: "Inter",
          color: AppColours.foregroundLight,
        ),
        bodySmall: const TextStyle(
          color: Colors.white,
          fontFamily: "Inter",
        ),
        labelLarge: const TextStyle(fontFamily: "Inter"),
        labelMedium: const TextStyle(fontFamily: "Inter"),
        labelSmall: const TextStyle(fontFamily: "Inter"),
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        elevation: 0.0,
        backgroundColor: AppColours.primary,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: AppColours.inputBgLight,
      ),
      listTileTheme: base.listTileTheme.copyWith(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        color: AppColours.backgroundLight,
        iconTheme: const IconThemeData(color: AppColours.foregroundLight),
        // toolbarTextStyle: base.textTheme.bodyText2,
        // titleTextStyle: base.textTheme.headline6,
      ),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
      ),
      cardTheme: base.cardTheme.copyWith(color: AppColours.cardBgLight),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColours.primary,
        primaryContrastingColor: AppColours.primary,
        // textTheme: _bookiemaCupertinoLightTextTheme(appleBase),
      ),
      applyElevationOverlayColor: false);
}

final ThemeData kaskaiDarkTheme = darkTheme();

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
      brightness: Brightness.dark,
      colorScheme: base.colorScheme.copyWith(
          background: AppColours.backgroundDark,
          primary: AppColours.primary,
          surface: AppColours.surfaceDark),
      scaffoldBackgroundColor: AppColours.backgroundDark,
      textTheme: base.textTheme.copyWith(
        headlineLarge: const TextStyle(
            color: AppColours.foregroundDark,
            // fontWeight: FontWeight.w600,
            fontFamily: "Inter"),
        headlineMedium: const TextStyle(
          color: AppColours.foregroundDark,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        headlineSmall: const TextStyle(
          color: AppColours.foregroundDark,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        titleLarge: const TextStyle(
          color: AppColours.foregroundDark,
          // fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        titleMedium: const TextStyle(
          color: AppColours.foregroundDark,
          // fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        titleSmall: const TextStyle(
          color: AppColours.foregroundDark,
          // fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        bodyLarge: const TextStyle(
          color: AppColours.foregroundDark,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: const TextStyle(
          fontFamily: "Inter",
          color: AppColours.foregroundDark,
        ),
        bodySmall: const TextStyle(
          color: Colors.white,
          fontFamily: "Inter",
        ),
        labelLarge: const TextStyle(fontFamily: "Inter"),
        labelMedium: const TextStyle(fontFamily: "Inter"),
        labelSmall: const TextStyle(fontFamily: "Inter"),
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        elevation: 0.0,
        backgroundColor: AppColours.primary,
        foregroundColor: AppColours.secondary,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: AppColours.surfaceDark,
      ),
      listTileTheme: base.listTileTheme.copyWith(
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        color: AppColours.backgroundDark,
        iconTheme: const IconThemeData(color: AppColours.foregroundDark),
        // toolbarTextStyle: base.textTheme.bodyText2,
        // titleTextStyle: base.textTheme.headline6,
      ),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
      ),
      cardTheme: base.cardTheme.copyWith(color: AppColours.surfaceDark),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColours.primary,
        primaryContrastingColor: AppColours.primary,
        // textTheme: _bookiemaCupertinoLightTextTheme(appleBase),
      ),
      applyElevationOverlayColor: false);
}
