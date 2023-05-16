import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company.dart';
import '../notifiers/company_notifier.dart';

final companyInfoNotifierProvider =
    StateNotifierProvider<CompanyInfoNotifier, CompanyInfo?>((ref) {
  final notifier = CompanyInfoNotifier();
  notifier.fetchCompanyInfo();
  return notifier;
});
