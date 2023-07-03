import 'models/model.dart';

class TrendAnalyzer {
  final MarketData? marketData;
  final String status;

  TrendAnalyzer(this.marketData, {this.status = 'data'});

  static TrendAnalyzer loading() => TrendAnalyzer(null, status: 'loading');
  static TrendAnalyzer error(err) => TrendAnalyzer(null, status: 'error');

  String analyzeTrend() {
    if (status == 'loading') {
      return 'Loading...';
    } else if (status == 'error') {
      return 'Error';
    }
    if (marketData == null) {
      return 'No market data';
    }

    var data = marketData!.timeSeriesFxDaily.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    var sortedData = data.map((entry) => entry.value).toList();

    if (sortedData.length < 10) {
      return 'Insufficient data';
    }
    double calculatePercentageChange() {
      if (sortedData.length < 5) {
        return 0.0; // Default value if there is insufficient data
      }

      double currentClose = double.parse(sortedData[0].the4Close);
      double previousClose = double.parse(sortedData[4].the4Close);

      double percentageChange =
          ((currentClose - previousClose) / previousClose) * 100;
      return percentageChange;
    }

    double percentageChange = calculatePercentageChange();

    // Calculate the SMA over the past 10 days
    double sma = sortedData
            .take(10)
            .map((d) => double.parse(d.the4Close))
            .reduce((a, b) => a + b) /
        10;

    // Compare the current closing value with the SMA
    double currentClose = double.parse(sortedData[0].the4Close);
    if (currentClose > sma) {
      return 'BUY: Potential upward momentum.\nLast 5 days: ${percentageChange.toStringAsFixed(2)}%';
    } else if (currentClose < sma) {
      return 'SELL: Potential downward momentum.\nLast 5 days: ${percentageChange.toStringAsFixed(2)}%';
    } else {
      return 'WAIT: Lack of significant bias towards either bullish or bearish sentiment.\nLast 5 days: ${percentageChange.toStringAsFixed(2)}%';
    }
  }
}
