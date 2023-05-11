import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../notifiers/forex_notifier.dart';

class ForexChart extends ConsumerWidget {
  const ForexChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(forexNotifierProvider).when(
          data: (data) {
            final dataPoints = data.timeSeriesFxDaily.entries
                .map((e) => _ChartData(
                      date: DateTime.parse(e.key),
                      open: double.parse(e.value.the1Open),
                      high: double.parse(e.value.the2High),
                      low: double.parse(e.value.the3Low),
                      close: double.parse(e.value.the4Close),
                    ))
                .toList();

            return SfCartesianChart(
              zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  enableDoubleTapZooming: true),
              crosshairBehavior: CrosshairBehavior(enable: true),
              primaryXAxis: DateTimeAxis(),
              primaryYAxis: NumericAxis(),
              series: <CandleSeries<_ChartData, DateTime>>[
                CandleSeries<_ChartData, DateTime>(
                  dataSource: dataPoints,
                  xValueMapper: (_ChartData data, _) => data.date,
                  lowValueMapper: (_ChartData data, _) => data.low,
                  highValueMapper: (_ChartData data, _) => data.high,
                  openValueMapper: (_ChartData data, _) => data.open,
                  closeValueMapper: (_ChartData data, _) => data.close,
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Error: $error'),
        );
  }
}

class _ChartData {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  _ChartData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}
