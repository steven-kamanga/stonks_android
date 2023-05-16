// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/db.dart';
import '../models/trade_model.dart';
import 'package:intl/intl.dart';

class TradeNotifier extends StateNotifier<List<Trade>> {
  TradeNotifier() : super([]);

  Future<void> executeTrade(
    String type,
    double price,
    double quantity,
    int marketId,
  ) async {
    Trade trade = Trade(
      id: DateTime.now().millisecondsSinceEpoch,
      type: type,
      price: price.toString(),
      quantity: quantity.toString(),
      date: DateTime.now().toIso8601String(),
      time: DateFormat('HH:mm:ss').format(DateTime.now()),
      marketId: marketId,
    );

    await ProfileDatabase.instance.insertTrade(trade);
    state = [...state, trade];
  }
}
