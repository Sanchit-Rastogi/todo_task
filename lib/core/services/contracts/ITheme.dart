import 'package:flutter/material.dart';

abstract class ITheme {
  Future<ThemeMode> getTheme();
} 