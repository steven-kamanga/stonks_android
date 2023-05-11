import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stonks_android/presentation/resources/color_manager.dart';
import 'package:stonks_android/presentation/resources/values_manager.dart';
import 'package:stonks_android/providers/profile_provider.dart';
import 'models/model.dart';

class MarketListView extends ConsumerWidget {
  final ProfileItem profileId;

  const MarketListView({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController marketName = TextEditingController();
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
            icon: FaIcon(
              FontAwesomeIcons.plus,
              color: ColorManager.white,
              size: 18,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: ColorManager.gray,
                    title: Text(
                      'Select Market',
                      style: TextStyle(
                        color: ColorManager.white,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            width: 5,
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
                  int profileIndex = ref
                      .read(profileProvider)
                      .indexWhere((profile) => profile.id == updatedProfile.id);
                  ref.read(profileProvider.notifier).deleteProfile(
                        profileIndex,
                        updatedProfile.markets![index],
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
