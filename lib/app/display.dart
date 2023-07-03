import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stonks_android/presentation/resources/color_manager.dart';
import 'package:stonks_android/presentation/resources/values_manager.dart';
import 'displaymarket.dart';
import 'market.dart';
import '../models/model.dart';
import '../providers/profile_provider.dart';

class Portfolio extends ConsumerWidget {
  const Portfolio({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController profileName = TextEditingController();
    final isLoading = ref.watch(profileProvider.notifier).isLoading;
    final profiles = ref.watch(profileProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: ColorManager.white,
          size: 18,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: ColorManager.grey,
                title: Text(
                  'Enter Portfolio Name',
                  style: TextStyle(
                    color: ColorManager.white,
                  ),
                ),
                content: TextField(
                  controller: profileName,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    hintText: 'Portfolio Name',
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      ref.read(profileProvider.notifier).addProfile(
                            ProfileItem(
                              name: profileName.text,
                              markets: [],
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 25,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s15,
                        ),
                        color: ColorManager.white,
                      ),
                      child: const Center(
                        child: Text('Save'),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      backgroundColor: ColorManager.black,
      appBar: AppBar(
        title: const Text('Portfolios'),
        elevation: 0,
        backgroundColor: ColorManager.black,
      ),
      body: !isLoading
          ? ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        title: Text(
                          profiles[index].name!,
                          style: TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                        children: [
                          Column(
                            children: profiles[index]
                                .markets!
                                .map<Widget>(
                                  (market) => InkWell(
                                      onTap: () {
                                        // Navigate to the MarketScreen with the market.id
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MarketScreen(
                                              marketId: market.id!,
                                              market: market.marketName!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: AppPadding.p20,
                                                right: AppPadding.p20,
                                              ),
                                              child: ListTile(
                                                tileColor: ColorManager.grey,
                                                title: Text(
                                                  market.marketName!,
                                                  style: TextStyle(
                                                    color: ColorManager.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: AppSize.s1,
                                            )
                                          ],
                                        ),
                                      )),
                                )
                                .toList(),
                          ),
                          SizedBox(
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: ColorManager.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MarketListView(
                                        profileId: profiles[index]),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorManager.white,
                ),
              ),
            ),
    );
  }
}
