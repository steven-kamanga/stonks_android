import 'package:flutter/material.dart';
import 'package:stonks_android/app/forex_chart.dart';

class MarketScreen extends StatelessWidget {
  final int marketId;

  const MarketScreen({
    super.key,
    required this.marketId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Screen'),
      ),
      body: SizedBox(child: ForexChart()),
    );
  }
}
