import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/db.dart';
import '../models/model.dart';

class ProfileNotifier extends StateNotifier<List<ProfileItem>> {
  int _nextMarketId = 1;
  final ProfileDatabase _profileDatabase = ProfileDatabase.instance;

  ProfileNotifier() : super([]) {
    _loadProfiles();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> _loadProfiles() async {
    _isLoading = true;
    final profiles = await _profileDatabase.getProfiles();
    for (var profile in profiles) {
      profile.markets =
          await _profileDatabase.getMarketsForProfile(profile.id!);
    }
    state = profiles;
    _isLoading = false;
  }

  Future<void> addProfile(ProfileItem profile) async {
    final newProfile = await _profileDatabase.createProfile(profile);
    state = [...state, newProfile];
  }

  Future<void> updateProfile(ProfileItem profile) async {
    await _profileDatabase.updateProfile(profile);
    final profiles =
        state.map((p) => p.id == profile.id ? profile : p).toList();
    state = profiles;
  }

  Future<void> deleteProfile(int profileIndex, Market market) async {
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

  Future<void> addMarketToProfile(int? profileId, Market market) async {
    final newMarket = await _profileDatabase.createMarket(market, profileId!);
    state = state.map((profile) {
      if (profile.id == profileId) {
        return ProfileItem(
            id: profile.id,
            name: profile.name,
            markets: [...profile.markets!, newMarket]);
      }
      return profile;
    }).toList();
  }

  Future<void> deleteMarketFromProfile(int? profileId, int marketId) async {
    await _profileDatabase.deleteMarket(marketId);
    state = state.map((profile) {
      if (profile.id == profileId) {
        return ProfileItem(
            id: profile.id,
            name: profile.name,
            markets: profile.markets!
                .where(
                  (m) => m.id != marketId,
                )
                .toList());
      }
      return profile;
    }).toList();
  }
}
