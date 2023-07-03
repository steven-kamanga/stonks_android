import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trade_model.dart';
import '../notifiers/trade_notifier.dart';

final tradeNotifierProvider =
    StateNotifierProvider<TradeNotifier, List<Trade>>((ref) {
  var tradeNotifier = TradeNotifier();
  tradeNotifier.fetchAllTrades();
  return tradeNotifier;
});
