import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/presentation/resources/values_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../notifiers/usdjpy_notifier.dart';

class UsdJpy extends ConsumerWidget {
  const UsdJpy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: AppPadding.p10,
                left: AppPadding.p10,
                right: AppPadding.p10,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ref.watch(usdjpyNotifierProvider).when(
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

                            DateTime minDate = dataPoints[0].date;
                            DateTime maxDate = dataPoints[0].date;

                            for (final data in dataPoints) {
                              if (data.date.isBefore(minDate)) {
                                minDate = data.date;
                              }
                              if (data.date.isAfter(maxDate)) {
                                maxDate = data.date;
                              }
                            }

                            const extraSpace = Duration(
                                days: 5); // Adjust the duration as needed
                            maxDate = maxDate.add(extraSpace);

                            return SfCartesianChart(
                              backgroundColor: Theme.of(context).canvasColor,
                              zoomPanBehavior: ZoomPanBehavior(
                                  enablePanning: true,
                                  enablePinching: true,
                                  enableDoubleTapZooming: true),
                              crosshairBehavior:
                                  CrosshairBehavior(enable: true),
                              primaryXAxis: DateTimeAxis(
                                minimum: minDate,
                                maximum: maxDate,
                              ),
                              primaryYAxis: NumericAxis(),
                              series: <CandleSeries<_ChartData, DateTime>>[
                                CandleSeries<_ChartData, DateTime>(
                                  dataSource: dataPoints,
                                  xValueMapper: (_ChartData data, _) =>
                                      data.date,
                                  lowValueMapper: (_ChartData data, _) =>
                                      data.low,
                                  highValueMapper: (_ChartData data, _) =>
                                      data.high,
                                  openValueMapper: (_ChartData data, _) =>
                                      data.open,
                                  closeValueMapper: (_ChartData data, _) =>
                                      data.close,
                                ),
                              ],
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (error, _) => Text('Error: $error'),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
