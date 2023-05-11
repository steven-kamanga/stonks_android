import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/db.dart';
import '../models/model.dart';

class ProfileNotifier extends StateNotifier<List<ProfileItem>> {
  final ProfileDatabase _profileDatabase = ProfileDatabase.instance;

  ProfileNotifier() : super([]) {
    _loadProfiles();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> _loadProfiles() async {
    _isLoading = true;
    final profiles = await _profileDatabase.getProfiles();
    state = profiles;
    _isLoading = false;
  }

  void addProfile(ProfileItem profile) async {
    final newProfile = await _profileDatabase.createProfile(profile);
    state = [...state, newProfile];
  }

  void updateProfile(ProfileItem profile) async {
    await _profileDatabase.updateProfile(profile);
    final profiles =
        state.map((p) => p.id == profile.id ? profile : p).toList();
    state = profiles;
  }

  void deleteProfile(int profileIndex, Market market) async {
    try {
      final profiles = state;
      final profile = profiles[profileIndex];
      await _profileDatabase.deleteProfile(
        profile.id!,
      );
      final updatedProfiles = profiles
          .where(
            (p) => p.id != profile.id,
          )
          .toList();
      state = updatedProfiles;
    } catch (e) {
      // Handle the error here
      print("Error: profile_notifier.dart");
      return Future.error(e);
    }
  }
}
