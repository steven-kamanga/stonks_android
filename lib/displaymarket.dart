import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/presentation/resources/color_manager.dart';
import 'package:stonks_android/presentation/resources/values_manager.dart';
import 'package:stonks_android/providers/profile_provider.dart';
import 'models/model.dart';

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
      backgroundColor: ColorManager.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.black,
        title: Text(updatedProfile.name!),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ref.read(profileProvider.notifier).addMarketToProfile(
                    updatedProfile.id!,
                    Market(
                      marketName: 'USDJPY',
                    ),
                  );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: updatedProfile.markets!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p20,
              right: AppPadding.p20,
            ),
            child: ListTile(
              title: Text(
                updatedProfile.markets![index].marketName!,
                style: TextStyle(
                  color: ColorManager.white,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: ColorManager.white,
                ),
                onPressed: () {
                  // Find the profile index based on the profile ID
                  int profileIndex = ref
                      .read(profileProvider)
                      .indexWhere((profile) => profile.id == updatedProfile.id);
                  // Call the deleteMarketFromProfile function with the profile index
                  // ref.read(profileProvider.notifier).deleteMarketFromProfile(
                  //       profileIndex,
                  //       updatedProfile.markets[index],
                  //     );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
