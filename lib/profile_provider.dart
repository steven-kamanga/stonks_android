import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/profile_item.dart';
import 'profile_notifier.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, List<ProfileItem>>(
        (ref) => ProfileNotifier());
