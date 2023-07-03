import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:stonks_android/app/order_screen.dart';
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
              const SizedBox(height: 20),
              const Text(
                'Market Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, watch, _) {
                  final marketData = ref.watch(eurusdNotifierProvider);

                  if (marketData is AsyncData) {
                    final closePrice = marketData
                        .value!.timeSeriesFxDaily.entries.first.value.the4Close;

                    return Column(
                      children: [
                        Text(
                          'Price: $closePrice MWK',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Quantity: $_quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _quantity = int.parse(value);
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 1000,
                divisions: 100,
                onChanged: (double newValue) {
                  setState(() {
                    _sliderValue = newValue;
                    _quantity = newValue.toInt();
                  });
                },
              ),
              Text('Selected Quantity: $_quantity'),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: _isLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.check),
                      label: const Text('Buy'),
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await ref
                                  .read(tradeNotifierProvider.notifier)
                                  .executeTrade(
                                    "Buy",
                                    double.parse(closePrice!),
                                    _quantity.toDouble(),
                                    widget.marketId,
                                  );
                              AwesomeNotifications().createNotification(
                                content: NotificationContent(
                                  id: 1,
                                  channelKey: 'basic',
                                  title: 'Market Order Executed',
                                  body: 'Price: $closePrice MWK',
                                ),
                              );
                              //material navigate to a new page
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderProcessing(
                                    marketId: widget.marketId,
                                    market: widget.market,
                                    quantity: _quantity,
                                  ),
                                ),
                              );

                              setState(() {
                                _isLoading = false;
                              });
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
