import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_defaultTheme);

  static final _defaultTheme = ThemeData.light();

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = _isDarkTheme(state);
    final newTheme = isDark ? ThemeData.light() : ThemeData.dark();
    await prefs.setBool('isDark', !isDark);
    state = newTheme;
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    state = isDark ? ThemeData.dark() : ThemeData.light();
  }

  bool _isDarkTheme(ThemeData theme) => theme.brightness == Brightness.dark;
}
