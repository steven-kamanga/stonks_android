import 'package:flutter_riverpod/flutter_riverpod.dart';
import './models/profile_item.dart';

class ProfileNotifier extends StateNotifier<List<ProfileItem>> {
  int _nextProfileId = 1;
  int _nextMarketId = 1;

  ProfileNotifier() : super([]);

  void addProfile(ProfileItem profile) {
    // Assign the next available ID and increment the counter
    final newProfile = ProfileItem(
        id: _nextProfileId, name: profile.name, markets: profile.markets);
    _nextProfileId++;

    state = [...state, newProfile];
  }

  void deleteProfile(ProfileItem profile) {
    state = state.where((element) => element.id != profile.id).toList();
  }

  void addMarketToProfile(int? profileId, Market market) {
    state = state.map((profile) {
      if (profile.id == profileId) {
        // Assign the next available ID and increment the counter
        final newMarket =
            Market(id: _nextMarketId, marketName: market.marketName);
        _nextMarketId++;

        return ProfileItem(
            id: profile.id,
            name: profile.name,
            markets: [...profile.markets, newMarket]);
      }
      return profile;
    }).toList();
  }

  void deleteMarketFromProfile(int profileIndex, Market market) {
    state[profileIndex].markets.remove(market);
    state = [...state];
  }
}
