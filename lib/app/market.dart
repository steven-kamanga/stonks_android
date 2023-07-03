import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/app/airtel.dart';
import 'package:stonks_android/app/eurusd.dart';
import 'package:stonks_android/app/usdjpy.dart';
import '../providers/trendAnalyzerProvider.dart';
import 'price_eurusd.dart';
import '../notifiers/theme_notifier.dart';

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
    Widget trendWidget = _getTrendWidget(market);
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
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Order(
                    marketId: marketId,
                    market: market,
                  ),
                ),
              );
            },
            child: const Text(
              "Buy",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: chartWidget),
          trendWidget,
        ],
      ),
    );
  }

  Widget _getChartWidget(String market) {
    switch (market) {
      case 'ICON':
        return const EurUsd();
      case 'NICO':
        return const UsdJpy();
      case 'FMB':
        return const AirtelMarket();
      //add more market cases here
      default:
        return const Center(
          child: Text('No chart available'),
        );
    }
  }

  Widget _getTrendWidget(String market) {
    switch (market) {
      case 'ICON':
        return Consumer(builder: (context, WidgetRef ref, child) {
          final trendAnalyzer = ref.watch(eurUsdTrendAnalyzerProvider);
          final trend = trendAnalyzer.analyzeTrend();
          return Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 13),
            child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    child: Text(
                  "TREND ANALYSIS\n\n$trend",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))),
          );
        });
      case 'NICO':
        return Consumer(builder: (context, WidgetRef ref, child) {
          final trendAnalyzer = ref.watch(eurJpyTrendAnalyzerProvider);
          final trend = trendAnalyzer.analyzeTrend();
          return Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 13),
            child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    child: Text(
                  "TREND ANALYSIS\n\n$trend",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))),
          );
        });
      // add more market cases here
      default:
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            child: Text('TREND ANALYSIS\nBUY: Potential upward momentum.'),
          ),
        );
    }
  }
}
