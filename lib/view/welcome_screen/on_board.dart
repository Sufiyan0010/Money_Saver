import 'package:flutter/material.dart';
import 'package:money_saver/view/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/styles.dart';
import 'boarding_pages/page_one.dart';
import 'boarding_pages/page_three.dart';
import 'boarding_pages/page_two.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              onLastPage
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      height: 30,
                      width: 80,
                      child: const Text(''))
                  : GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 7, 255, 197),
                          ),
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          child: Text('Skip',
                              style: TextStyle(
                                  color: blueShade,
                                  fontFamily: 'hubballi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
              ),
              onLastPage
                  ? GestureDetector(
                      onTap: () async {
                        final pref = await SharedPreferences.getInstance();
                        pref.setBool('seen', true);
                        rootPageNavigataor();
                      },
                       child: 
                      //Stack(children: [
                      //   Lottie.asset(
                      //     'assets/button.json',
                      //     width: 100,
                      //   ),
                      //   Positioned(
                      //     top: 5,
                      //     left: 5,
                      //     child: Text('Continue',
                      //         style: TextStyle(
                      //             color: whiteShade,
                      //             fontFamily: 'hubballi',
                      //             fontSize: 25,
                      //             fontWeight: FontWeight.bold)),
                      //   ),
                      // ])
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: bodyColor
                        ),
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                      child: Text('Continue',
                          style: TextStyle(
                              color: greenShade,
                              fontFamily: 'hubballi',
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      ),
                      )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration:const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 0, 200, 255),
                          ),
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          child: Text('Next',
                              style: TextStyle(
                                  color: blueShade,
                                  fontFamily: 'hubballi',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)))),
            ],
          ),
        )
      ],
    ));
  }

  rootPageNavigataor() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: ((context) => const RootPage())),
        (route) => false);
  }
}
