import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/news.dart';
import '../notifiers/news_notifier.dart';
import '../notifiers/theme_notifier.dart';
import '../presentation/resources/color_manager.dart';

class Landing extends ConsumerWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDark = ref.watch(themeNotifierProvider).brightness == Brightness.dark;
    var news = ref.watch(newsNotifierProvider);

    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: AppBar(
        elevation: 0,
        title: TextButton(
          onPressed: () {},
          child: Text(
            "Investing",
            style: TextStyle(
              color: ColorManager.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorManager.black,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 18,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.solidBell,
              size: 18,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: news.when(
        data: (News news) {
          return ListView.builder(
            itemCount: news.data.length,
            itemBuilder: (context, index) {
              Datum item = news.data[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.imageUrl),
                  ),
                  title: Text(item.title,
                      style: TextStyle(color: ColorManager.white)),
                  subtitle: Text(item.description,
                      style: TextStyle(color: ColorManager.white)),
                  onTap: () {
                    // Handle tap event, e.g., navigate to a detail page
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
