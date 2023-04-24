import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/profile_provider.dart';
import 'models/profile_item.dart';

class MarketListView extends ConsumerWidget {
  final ProfileItem profileId;

  const MarketListView({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Find the updated profile from the provider using the selectedProfile.id
    final updatedProfile = ref
        .watch(profileProvider)
        .firstWhere((profile) => profile.id == profileId.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(updatedProfile.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ref.read(profileProvider.notifier).addMarketToProfile(
                    updatedProfile.id!,
                    Market(
                      marketName: 'New Market',
                    ),
                  );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: updatedProfile.markets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(updatedProfile.markets[index].marketName),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Find the profile index based on the profile ID
                int profileIndex = ref
                    .read(profileProvider)
                    .indexWhere((profile) => profile.id == updatedProfile.id);
                // Call the deleteMarketFromProfile function with the profile index
                ref.read(profileProvider.notifier).deleteMarketFromProfile(
                      profileIndex,
                      updatedProfile.markets[index],
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
