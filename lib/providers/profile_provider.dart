import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/model.dart';
import '../notifiers/profile_notifier.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, List<ProfileItem>>(
        (ref) => ProfileNotifier());
