import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/styles.dart';


class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenShade,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:15,top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME:\nTHANK YOU \nFOR \nCHOOSING OUR\nMONEY SAVER\nAPP!',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Hubballi',
                    color: whiteShade,
                    fontWeight: FontWeight.bold),
              ),
              
             
            SizedBox(
              height: MediaQuery.of(context).size.height *0.5,
              width: MediaQuery.of(context).size.height *0.5,
              child: Lottie.asset('assets/Comp.json'))
            ],
          ),
        ),
      ),
    );
  }
}
