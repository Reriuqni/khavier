import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getDefaultTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.standard,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Colors.black),
    canvasColor: primaryColor,
  );
}
