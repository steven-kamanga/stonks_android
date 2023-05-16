import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/company.dart';

class CompanyInfoNotifier extends StateNotifier<CompanyInfo?> {
  CompanyInfoNotifier() : super(null);

  Future<void> fetchCompanyInfo() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data/company_json.json');
      print("Json: $jsonString");
      final jsonResult = jsonDecode(jsonString);
      state = CompanyInfo.fromJson(jsonResult);
    } catch (e) {
      // Handle exceptions
      print(e);
    }
  }
}
