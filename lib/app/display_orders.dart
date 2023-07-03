import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/app/trade_details.dart';
import 'package:stonks_android/presentation/resources/values_manager.dart';
import 'package:stonks_android/providers/trader_provider.dart';

class DisplayAllTrades extends ConsumerWidget {
  const DisplayAllTrades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trades = ref.watch(tradeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.builder(
          itemCount: trades.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text(
                          'Are you sure you want to Close this trade?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                ref
                    .read(tradeNotifierProvider.notifier)
                    .deleteTrade(trades[index].id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Trade closed'),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s15),
                    color: Colors.grey[800],
                  ),
                  child: ListTile(
                    title: Text(
                      () {
                        switch (trades[index].marketId) {
                          case 1:
                            return 'NICO';
                          case 2:
                            return 'ICO';
                          case 3:
                            return 'FMB';
                          default:
                            return 'Unknown Market';
                        }
                      }(),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              TradeDetailsPage(trade: trades[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
