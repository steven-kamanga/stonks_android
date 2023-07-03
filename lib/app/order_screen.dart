import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../notifiers/eruusd_notifier.dart';
import '../providers/trader_provider.dart';

class OrderProcessing extends ConsumerStatefulWidget {
  final int marketId;
  final String market;
  final int quantity;

  const OrderProcessing({
    super.key,
    required this.quantity,
    required this.marketId,
    required this.market,
  });

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends ConsumerState<OrderProcessing> {
  bool _isLoading = false;
  String market = '';
  int quantity = 0;
  @override
  void initState() {
    quantity = widget.quantity;
    market = widget.market;
    super.initState();
  }

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
                'Market Order Processed',
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

                    return Text(
                      'Bought $quantity Shares of $market\n @ $closePrice MWK each',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
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
                                    quantity.toDouble(),
                                    widget.marketId,
                                  );
                              AwesomeNotifications().createNotification(
                                content: NotificationContent(
                                  id: 1,
                                  channelKey: 'basic',
                                  title: 'Market Order Executed',
                                  body: 'Price: $closePrice MWK',
                                  summary: 'Market: $market',
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
