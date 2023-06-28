import '../models/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/usdjpy_api_provider.dart';

final marketNotifierProvider =
    StateNotifierProvider.autoDispose<StockNotifier, AsyncValue<MarketData>>(
        (ref) {
  return StockNotifier(ref);
});

class StockNotifier extends StateNotifier<AsyncValue<MarketData>> {
  final AutoDisposeStateNotifierProviderRef<StockNotifier,
      AsyncValue<MarketData>> _ref;

  StockNotifier(
    this._ref,
  ) : super(
          const AsyncValue.loading(),
        ) {
    _fetchStockData();
  }

  Future<void> _fetchStockData() async {
    try {
      final forexData = await _ref
          .read(
            usdjpyApiProvider,
          )
          .fetchStockData();
      state = AsyncValue.data(
        forexData,
      );
    } catch (e) {
      state = AsyncValue.error(
        e,
        StackTrace.current,
      );
    }
  }
}
