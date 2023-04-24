import 'package:flutter/material.dart';
import 'package:stonks_android/app/landing.dart';

import 'app/nav_bar.dart';
import 'display.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileListView(),
    );
  }
}
