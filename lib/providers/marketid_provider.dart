import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/providers/trader_provider.dart';
import 'package:stonks_android/providers/xxl.dart';

import '../models/trade_model.dart';

final tradesForProfileProvider = Provider<List<Trade>>((ref) {
  final profile = ref.watch(profileNotifierProvider.select((state) =>
      state.firstWhere((p) => p.id == ref.watch(currentProfileIdProvider))));
  return ref
      .watch(tradeNotifierProvider)
      .where((t) => profile.markets!.any((m) => m.id == t.marketId))
      .toList();
});
