import '../models/model.dart';
import '../models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/news_provider.dart';

final newsNotifierProvider =
    StateNotifierProvider.autoDispose<NewsNotifier, AsyncValue<News>>((ref) {
  return NewsNotifier(ref.watch(newsApiProvider.future));
});

class NewsNotifier extends StateNotifier<AsyncValue<News>> {
  final Future<News> _data;

  NewsNotifier(this._data) : super(const AsyncValue.loading()) {
    _fetchNewsData();
  }

  Future<void> _fetchNewsData() async {
    try {
      final newsData = await _data;
      state = AsyncValue.data(newsData);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
