import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/styles.dart';


class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenShade,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GET VALUABLE \nINSIGHTS \nINTO YOUR\nSPENDING \nHABITS ',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Hubballi',
                    color: whiteShade,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.height * 0.5,
                  child: Lottie.asset('assets/companystat.json')),
            ],
          ),
        ),
      ),
    );
  }
}
