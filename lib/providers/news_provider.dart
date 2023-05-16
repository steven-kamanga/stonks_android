import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/constants/constants.dart';
import 'package:stonks_android/models/news.dart';

final newsApiProvider = FutureProvider<News>((ref) async {
  final response = await http.get(Uri.parse(Urls.News));
  if (response.statusCode == 200) {
    return newsFromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
});
