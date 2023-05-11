import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stonks_android/app/landing.dart';

import '../presentation/resources/color_manager.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List _pages = [const Landing(), const Landing()];
  int _selectedIndex = 0;

  _navBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorManager.black,
        selectedItemColor: ColorManager.white,
        unselectedItemColor: ColorManager.gray,
        currentIndex: _selectedIndex,
        onTap: _navBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              size: 19,
              FontAwesomeIcons.chartLine,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              size: 19,
              FontAwesomeIcons.solidNewspaper,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              size: 19,
              FontAwesomeIcons.user,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
