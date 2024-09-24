import 'package:chatnew/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static MyTheme get currentTheme => GetIt.I<MyTheme>();
  static ThemeMode get themeMode => GetIt.I<MyTheme>().currentTheme();

  static ThemeData lightTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: currentTheme.currentColor(),
      dividerColor: currentTheme.currentColor().withOpacity(0.2),
      fontFamily: 'Montserrat',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: currentTheme.currentColor(),
            // backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: 018,
            )),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ))),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: currentTheme.currentColor(),
        cursorColor: currentTheme.currentColor(),
        selectionColor: currentTheme.getColor('AppColor', 100),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        suffixIconColor: currentTheme.currentColor(),
        prefixIconColor: currentTheme.currentColor(),
        fillColor: Colors.black,
        focusColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        // color: const Color.fromRGBO(236, 245, 251, 1),

        margin: const EdgeInsets.only(bottom: 15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      disabledColor: Colors.grey[600],
      brightness: Brightness.light,
      indicatorColor: currentTheme.currentColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(color: currentTheme.currentColor()),
      iconTheme: IconThemeData(
        color: currentTheme.currentColor(),
        opacity: 1.0,
        size: 24.0,
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: currentTheme.currentColor(),
          brightness: Brightness.light,
          secondary: Colors.white,
          secondaryContainer: const Color.fromRGBO(19, 51, 99, 0.05),
          primaryContainer: const Color.fromRGBO(244, 248, 255, 1),
          onSurface: Colors.black,
          shadow: Colors.grey),
      hintColor: Colors.grey,
      dialogTheme: DialogTheme(
        elevation: 5,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(fontSize: 18, color: currentTheme.currentColor(), fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actionsPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 50.0),
      appBarTheme: AppBarTheme(
          backgroundColor: currentTheme.currentColor(),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          foregroundColor: Colors.white),
    );
  }

  static ThemeData darkTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: currentTheme.currentColor(),
      dividerColor: currentTheme.currentColor().withOpacity(0.2),
      fontFamily: 'Montserrat',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: currentTheme.currentColor(),
            // backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: 018,
            )),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ))),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: currentTheme.currentColor(),
        cursorColor: currentTheme.currentColor(),
        selectionColor: currentTheme.getColor('AppColor', 100),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        suffixIconColor: Colors.white,
        prefixIconColor: Colors.white,
        fillColor: Colors.black,
        focusColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: currentTheme.currentColor(),
            backgroundColor: Colors.white,
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        // color: const Color.fromRGBO(236, 245, 251, 1),
        margin: const EdgeInsets.only(bottom: 15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      disabledColor: Colors.grey[600],
      brightness: Brightness.dark,
      indicatorColor: currentTheme.currentColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(color: currentTheme.currentColor()),
      iconTheme: IconThemeData(
        color: Colors.white,
        opacity: 1.0,
        size: 24.0,
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: currentTheme.currentColor(),
          brightness: Brightness.dark,
          secondary: Colors.black,
          secondaryContainer: const Color.fromRGBO(19, 51, 99, 0.05),
          primaryContainer: const Color.fromRGBO(244, 248, 255, 1),
          onSurface: Colors.black,
          shadow: Colors.grey),
      hintColor: Colors.grey,
      dialogTheme: DialogTheme(
        elevation: 5,
        backgroundColor: currentTheme.currentColor().withOpacity(0.8),
        titleTextStyle: TextStyle(fontSize: 18, color: currentTheme.currentColor(), fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actionsPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 50.0),
      appBarTheme: AppBarTheme(
          backgroundColor: currentTheme.currentColor(),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          foregroundColor: Colors.white),
    );
  }
}
