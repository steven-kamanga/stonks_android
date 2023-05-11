import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/app/eurusd.dart';
import 'package:stonks_android/app/usdjpy.dart';

import 'notifiers/theme_notifier.dart';

class MarketScreen extends ConsumerWidget {
  final int marketId;
  final String market;

  const MarketScreen({
    super.key,
    required this.marketId,
    required this.market,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark =
        ref.watch(themeNotifierProvider).brightness == Brightness.dark;
    Widget chartWidget = _getChartWidget(market);
    return Scaffold(
      appBar: AppBar(
        title: Text(market),
        actions: [
          IconButton(
            icon: isDark
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.attach_money))
        ],
      ),
      body: SizedBox(
        child: chartWidget,
      ),
    );
  }

  Widget _getChartWidget(String market) {
    switch (market) {
      case 'EURUSD':
        return const EurUsd();
      case 'USDJPY':
        return const UsdJpy();
      //add more market cases here
      default:
        return const Text('No chart available');
    }
  }
}
