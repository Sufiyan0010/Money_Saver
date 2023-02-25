import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_saver/home/root_page.dart';
import 'package:money_saver/welcome_screen/on_board.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //==================Delay Fn Call======================\\
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), (() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool seen = preferences.getBool('seen') ?? false;
      seen ? gotoRootPage() :gotoOnboard();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: greenShade,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'MONEY SAVER',
              style: TextStyle(
                  color: whiteShade,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Hubballi'),
            ),
          ],
        ),
      ),
    );
  }
  //=====================Name Check===============\\

  //=================Replace Fn===========================\\

  gotoRootPage() async{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RootPage()));
  }

  gotoOnboard() async{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const OnBoardPage()));
  }
}
