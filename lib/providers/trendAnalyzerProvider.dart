import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/providers/usdjpy_api_provider.dart';
import '../trend_analyzer.dart';
import 'eurjpy_api_provider.dart';
import 'eurusd_api_provider.dart';

final eurUsdTrendAnalyzerProvider = Provider.autoDispose<TrendAnalyzer>((ref) {
  final marketDataAsyncValue = ref.watch(eurusdApiProvider);
  return marketDataAsyncValue.when(
    data: (marketData) => TrendAnalyzer(marketData),
    loading: () => TrendAnalyzer.loading(),
    error: (err, stackTrace) => TrendAnalyzer.error(err),
  );
});

final eurJpyTrendAnalyzerProvider = Provider.autoDispose<TrendAnalyzer>((ref) {
  final marketDataAsyncValue = ref.watch(eurjpyApiProvider);
  return marketDataAsyncValue.when(
    data: (marketData) => TrendAnalyzer(marketData),
    loading: () => TrendAnalyzer.loading(),
    error: (err, stackTrace) => TrendAnalyzer.error(err),
  );
});
