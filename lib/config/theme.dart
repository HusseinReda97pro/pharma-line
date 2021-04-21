import 'package:flutter/material.dart';

import 'Palette.dart';

ThemeData appTheme = ThemeData(
  primaryColor: Palette.midBlue,
  appBarTheme: AppBarTheme(color: Palette.midBlue),
  accentColor: Palette.lightBlue,
  // Define the default font family.
  fontFamily: 'SegoeUI',
  textTheme: TextTheme(
    headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  scaffoldBackgroundColor: Palette.darkBlue,
);
