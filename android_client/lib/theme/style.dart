import 'package:flutter/material.dart';

//This file is going to be used for storing multiple themes, that way making the code more readable
//If you want to make a new theme then just make a function that returns ThemeData class and then you can call that function anywhere
//where this file is imported.
//In the future I might make a live theme switcher for customizability.

ThemeData getDefaultTheme() {
  return ThemeData(
    brightness: Brightness.light
  );
}