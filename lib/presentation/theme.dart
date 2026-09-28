import 'package:flutter/material.dart';

abstract final class Palette {
  static const paper = Color(0xFFF6F5EF);
  static const ink = Color(0xFF233D35);
  static const muted = Color(0xFF6A766D);
  static const line = Color(0xFFDDE1D6);
  static const lime = Color(0xFFE4EDAE);
  static const softGreen = Color(0xFFE8EDE3);
  static const orange = Color(0xFF955332);
  static const red = Color(0xFFB3261E);
  static const softOrange = Color(0xFFF6EADD);
}

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Palette.paper,
  colorScheme: const ColorScheme.light(
    primary: Palette.ink,
    onPrimary: Colors.white,
    secondary: Palette.lime,
    onSecondary: Palette.ink,
    surface: Palette.paper,
    onSurface: Palette.ink,
    onSurfaceVariant: Palette.muted,
    outline: Palette.line,
    error: Palette.orange,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 42,
      height: 1.08,
      letterSpacing: -1.8,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      height: 1.15,
      letterSpacing: -0.8,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      letterSpacing: -0.5,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, height: 1.45),
    bodyMedium: TextStyle(fontSize: 14, height: 1.45),
    labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  ).apply(bodyColor: Palette.ink, displayColor: Palette.ink),
  appBarTheme: const AppBarTheme(
    backgroundColor: Palette.paper,
    foregroundColor: Palette.ink,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Roboto',
      color: Palette.ink,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 56),
      side: const BorderSide(color: Palette.line),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Palette.line),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Palette.line),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Palette.ink, width: 1.5),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Palette.ink,
    linearTrackColor: Palette.line,
    linearMinHeight: 5,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
);

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color = Palette.muted});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(
      color: color,
      fontSize: 11,
      letterSpacing: 1.8,
      fontWeight: FontWeight.w600,
    ),
  );
}
