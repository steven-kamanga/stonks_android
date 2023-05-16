import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/models/airtel.dart';
import '../notifiers/airtel_notifier.dart';

final airtelNotifierProvider =
    StateNotifierProvider<AirtelNotifier, Airtel?>((ref) {
  final notifier = AirtelNotifier();
  notifier.fetchCompanyInfo();
  return notifier;
});
