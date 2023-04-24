import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'displaymarket.dart';
import 'market.dart';
import 'models/profile_item.dart';
import 'profile_provider.dart';

class ProfileListView extends ConsumerWidget {
  const ProfileListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ref.read(profileProvider.notifier).addProfile(
                    ProfileItem(
                      name: 'New Profile',
                      markets: [],
                    ),
                  );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(profiles[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                ref.read(profileProvider.notifier).deleteProfile(
                      profiles[index],
                    );
              },
            ),
            children: [
              Column(
                children: profiles[index]
                    .markets
                    .map<Widget>(
                      (market) => InkWell(
                        onTap: () {
                          // Navigate to the MarketScreen with the market.id
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MarketScreen(marketId: market.id!),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(market.marketName),
                        ),
                      ),
                    )
                    .toList(),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MarketListView(profileId: profiles[index]),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
