import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../notifiers/eruusd_notifier.dart';
import '../providers/trader_provider.dart';

class Order extends ConsumerStatefulWidget {
  final int marketId;
  final String market;

  const Order({
    super.key,
    required this.marketId,
    required this.market,
  });

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends ConsumerState<Order> {
  bool _isLoading = false;
  int _quantity = 0;
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    var price = ref.watch(eurusdNotifierProvider);
    final closePrice =
        price.value?.timeSeriesFxDaily.entries.first.value.the4Close;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.market),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              // ... other widgets ...
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _quantity = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (double newValue) {
                  setState(() {
                    _sliderValue = newValue;
                    _quantity = newValue.toInt();
                  });
                },
              ),
              Text('Selected Quantity: $_quantity'),
              // ... other widgets ...
            ],
          ),
        ),
      ),
    );
  }
}
