import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('Market ID: $marketId'),
      ),
    );
  }
}
