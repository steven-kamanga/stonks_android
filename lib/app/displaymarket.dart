import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stonks_android/presentation/resources/color_manager.dart';
import 'package:stonks_android/presentation/resources/values_manager.dart';
import 'package:stonks_android/providers/profile_provider.dart';
import '../models/model.dart';

class MarketListView extends ConsumerWidget {
  final ProfileItem profileId;

  const MarketListView({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Find the updated profile from the provider using the selectedProfile.id

    final updatedProfile = ref.watch(profileProvider.select((profiles) =>
        profiles.firstWhere((profile) => profile.id == profileId.id)));

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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  var marketNames = [
                    'MSM',
                    'ART',
                  ];
                  return AlertDialog(
                    backgroundColor: ColorManager.grey,
                    title: Text(
                      'Select a Market',
                      style: TextStyle(color: ColorManager.white),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: marketNames.map((marketName) {
                          return ListTile(
                            title: Text(
                              marketName,
                              style: TextStyle(color: ColorManager.white),
                            ),
                            onTap: () {
                              ref
                                  .read(profileProvider.notifier)
                                  .addMarketToProfile(
                                    updatedProfile.id!,
                                    Market(
                                      marketName: marketName,
                                    ),
                                  );
                              Navigator.of(context).pop();
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
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
                  // Call the deleteMarketFromProfile function with the updatedProfile.id
                  ref.read(profileProvider.notifier).deleteMarketFromProfile(
                        updatedProfile.id,
                        updatedProfile.markets![index].id!,
                      );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showMarketListDialog(
    BuildContext context, WidgetRef ref, ProfileItem updatedProfile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var marketNames = [
        'EURUSD',
        'USDJPY',
      ];
      return AlertDialog(
        title: const Text('Select a Market'),
        content: ListView.builder(
          itemCount: marketNames.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(marketNames[index]),
              onTap: () {
                ref.read(profileProvider.notifier).addMarketToProfile(
                      updatedProfile.id!,
                      Market(
                        marketName: marketNames[index],
                      ),
                    );
                Navigator.of(context).pop();
              },
            );
          },
        ),
      );
    },
  );
}
