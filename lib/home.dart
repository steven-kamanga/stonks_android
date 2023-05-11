import 'package:flutter/material.dart';
import 'package:stonks_android/app/landing.dart';
import 'package:flutter_k_chart/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/nav_bar.dart';
import 'display.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const ProfileListView(),
    );
  }
}
