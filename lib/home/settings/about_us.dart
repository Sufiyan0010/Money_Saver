import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(
              fontFamily: 'hubballi',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: whiteShade),
        ),
        backgroundColor: greenShade,
        elevation: 10,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  Image.asset(
                    'assets/logo.png',
                    height: 100.0,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Money Saver',
                    style: TextStyle(
                        fontFamily: 'hubballi',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: blueShade),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontFamily: 'hubballi',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blueShade),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Money Saver is a mobile app that helps users do add income and expense and track. Our mission is to make it easy for people to accomplish their goals and improve their lives. We are a team of passionate developers who are dedicated to creating the best possible user experience.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
             const Text(
                'Developed by Sufiyan',
                style: TextStyle(
                    fontFamily: 'hubballi',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 205, 205, 205)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
