import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black.withOpacity(0.72),
  primarySwatch: Colors.green,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    iconSize: 35,
    backgroundColor: Color.fromRGBO(30, 215, 96, 1),
    elevation: 0,
    hoverElevation: 0,
    hoverColor: Color.fromRGBO(78, 210, 124, 1),
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(Colors.grey),
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      padding: MaterialStatePropertyAll(EdgeInsets.zero),
      iconSize: MaterialStatePropertyAll(50.0),
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 3,
    thumbColor: Colors.white,
    activeTrackColor: const Color.fromRGBO(30, 215, 96, 1),
    overlayColor: Colors.transparent,
    inactiveTrackColor: Colors.grey.shade800,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(
        Colors.white.withOpacity(0.5),
      ),
    ),
  ),
  textTheme: GoogleFonts.rubikTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme),
);
