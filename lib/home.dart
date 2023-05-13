import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/app/landing.dart';
import 'package:stonks_android/notifiers/theme_notifier.dart';
import 'app/nav_bar.dart';
import 'app/display.dart';

class Home extends ConsumerWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeNotifierProvider),
      home: const ProfileListView(),
    );
  }
}
