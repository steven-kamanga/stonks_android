import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nico.dart';
import '../notifiers/nico_notifier.dart';

final nicoNotifierProvider = StateNotifierProvider<NicoNotifier, Nico?>((ref) {
  final notifier = NicoNotifier();
  notifier.fetchCompanyInfo();
  return notifier;
});
