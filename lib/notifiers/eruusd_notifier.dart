import '../models/model.dart';
import '../providers/eurusd_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eurusdNotifierProvider =
    StateNotifierProvider.autoDispose<ForexNotifier, AsyncValue<MarketData>>(
        (ref) {
  return ForexNotifier(ref.watch(eurusdApiProvider.future));
});

class ForexNotifier extends StateNotifier<AsyncValue<MarketData>> {
  final Future<MarketData> _data;

  ForexNotifier(this._data) : super(const AsyncValue.loading()) {
    _fetchForexData();
  }

  Future<void> _fetchForexData() async {
    try {
      final forexData = await _data;
      state = AsyncValue.data(forexData);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
