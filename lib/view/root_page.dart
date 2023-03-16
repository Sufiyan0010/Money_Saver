import 'package:flutter/material.dart';
import 'package:money_saver/view/categories/categories.dart';
import 'package:money_saver/view/insights/insights.dart';
import 'package:money_saver/view/settings/settings.dart';
import 'package:money_saver/view/transactions/homescreen.dart';

import '../core/styles.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  //==============RootPage Lists============\\
  static const List<Widget> homeScreens = [
    HomeScreen(),
    Categories(),
    Insights(),
    SettingsPage(),
  ];

  @override
  State<RootPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<RootPage> {
  dynamic currentBackPressTime;

//==============RootPage Lists============\\

  int pageIndex = 0;

  changeindex(index) {
    setState(() {
      pageIndex = index;
    
    });
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: MediaQuery.of(context).size.width * 2 /5,
          backgroundColor: const Color.fromARGB(179, 0, 0, 0),
          behavior: SnackBarBehavior.floating,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          content: const Text(
            "Tap again to exit",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
        ),
      );

      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        //===============Bottom Nav=====================\\

        body: RootPage.homeScreens.elementAt(pageIndex),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (value) => changeindex(value),
          type: BottomNavigationBarType.fixed,
          backgroundColor: greenShade,
          selectedItemColor: Colors.white,
          unselectedItemColor: whiteShade,
          selectedLabelStyle: const TextStyle(
            fontSize: 18,
            fontFamily: 'hubballi',
            fontWeight: FontWeight.w800,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 23,
          ),
          showUnselectedLabels: false,
          selectedIconTheme: const IconThemeData(
            size: 23,
          ),
          items: [
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: pageIndex == 0
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home_outlined),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: pageIndex == 1
                    ? const Icon(Icons.grid_view_rounded)
                    : const Icon(Icons.grid_view_outlined),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: pageIndex == 2
                    ? const Icon(Icons.bar_chart)
                    : const Icon(Icons.bar_chart_rounded),
              ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: pageIndex == 3
                    ? const Icon(Icons.settings_sharp)
                    : const Icon(Icons.settings_outlined),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
