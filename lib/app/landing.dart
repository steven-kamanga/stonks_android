import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../presentation/resources/color_manager.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: const [
            Text(
              "data",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
