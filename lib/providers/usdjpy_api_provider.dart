import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/constants/constants.dart';
import '../models/model.dart';

final usdjpyApiProvider = Provider.autoDispose<ForexApi>((ref) {
  return ForexApi(ref);
});

class ForexApi {
  final ProviderRef _ref;

  ForexApi(this._ref);

  Future<MarketData> fetchStockData() async {
    final response = await http.get(
      Uri.parse(
        Urls.usdJpy,
      ),
    );
    if (response.statusCode == 200) {
      return marketDataFromJson(
        response.body,
      );
    } else {
      throw Exception(
        'Failed to load data',
      );
    }
  }
}
