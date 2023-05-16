import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nico.dart';

class NicoNotifier extends StateNotifier<Nico?> {
  NicoNotifier() : super(null);

  Future<void> fetchCompanyInfo() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/nico.json');
      final jsonResult = jsonDecode(jsonString);
      state = Nico.fromJson(jsonResult);
      print("Json: $jsonString");
    } catch (e) {
      // Handle exceptions
      print(e);
    }
  }
}
