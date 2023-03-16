import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../styles/styles.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                'TRACK YOUR \nEXPENSES \nAND\nSAVE YOUR \nMONEY HERE...',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Hubballi',
                    color: blueShade,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.height * 0.5,
                child: Lottie.asset('assets/savemoney.json')),
          ],
        ),
      ),
    );
  }
}
