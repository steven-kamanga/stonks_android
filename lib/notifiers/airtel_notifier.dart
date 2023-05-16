import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/models/airtel.dart';

class AirtelNotifier extends StateNotifier<Airtel?> {
  AirtelNotifier() : super(null);

  Future<void> fetchCompanyInfo() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data/airtel.json');
      print("Json: $jsonString");
      final jsonResult = jsonDecode(jsonString);
      state = Airtel.fromJson(jsonResult);
    } catch (e) {
      // Handle exceptions
      print(e);
    }
  }
}
