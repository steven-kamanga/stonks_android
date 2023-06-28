import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/model.dart';
import '../notifiers/profile_notifier.dart';

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, List<ProfileItem>>(
        (ref) => ProfileNotifier());
final currentProfileIdProvider = StateProvider<int?>((ref) => null);
