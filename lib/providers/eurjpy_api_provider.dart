import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/constants/constants.dart';
import '../models/model.dart';

final eurjpyApiProvider = FutureProvider.autoDispose<MarketData>((ref) async {
  final response = await http.get(Uri.parse(Urls.eurJpy));
  if (response.statusCode == 200) {
    return marketDataFromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
});
