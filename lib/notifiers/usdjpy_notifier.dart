import '../models/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/usdjpy_api_provider.dart';

final usdjpyNotifierProvider =
    StateNotifierProvider.autoDispose<ForexNotifier, AsyncValue<MarketData>>(
        (ref) {
  return ForexNotifier(ref);
});

class ForexNotifier extends StateNotifier<AsyncValue<MarketData>> {
  final AutoDisposeStateNotifierProviderRef<ForexNotifier,
      AsyncValue<MarketData>> _ref;

  ForexNotifier(
    this._ref,
  ) : super(
          const AsyncValue.loading(),
        ) {
    _fetchForexData();
  }

  Future<void> _fetchForexData() async {
    try {
      final forexData = await _ref
          .read(
            usdjpyApiProvider,
          )
          .fetchForexData();
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
