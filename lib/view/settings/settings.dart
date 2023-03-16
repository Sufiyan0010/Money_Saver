import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_saver/view/settings/about_us.dart';
import 'package:money_saver/view/settings/privacy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/category_model/category_model.dart';
import '../../models/transactions_model/transaction_model.dart';
import '../../core/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../splash/splash.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        //============= ===============App Bar===================\\

        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(
                fontFamily: 'hubballi',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: whiteShade),
          ),
          backgroundColor: greenShade,
          elevation: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.info_rounded,
                      size: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    title: Text(
                      'About us',
                      style: TextStyle(
                          fontFamily: 'hubballi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blueShade),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: const AboutUs(),
                            type: PageTransitionType.fade,
                          ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.star,
                      size: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    title: Text(
                      'Rate us',
                      style: TextStyle(
                          fontFamily: 'hubballi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blueShade),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.description,
                      size: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    title: Text(
                      'Terms and Conditions',
                      style: TextStyle(
                          fontFamily: 'hubballi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blueShade),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: const Privacy(),
                            type: PageTransitionType.fade,
                          ));
                    },
                  ),
                  ListTile(
                    onTap: () async {
                      const url =
                          'mailto:decodesdeveloper@gmail.com?subject=FeedBack &body=Hi,Money Saver';
                      Uri uri = Uri.parse(url);
                      await launchUrl(uri);
                    },
                    leading: const Icon(
                      Icons.feedback,
                      size: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    title: Text(
                      'FeedBack',
                      style: TextStyle(
                          fontFamily: 'hubballi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blueShade),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Share.share(
                          'Hello,Every one! Check Out Our New App https://play.google.com');
                    },
                    leading: const Icon(
                      Icons.share,
                      size: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    title: Text(
                      'Share',
                      style: TextStyle(
                          fontFamily: 'hubballi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blueShade),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.refresh,
                      size: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            elevation: 0,
                            backgroundColor: bodyColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      resetApp();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(
                                          fontFamily: 'hubballi',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontFamily: 'hubballi',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: blueShade),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                            title: const Text(
                              "WARNING!",
                              style: TextStyle(
                                  fontFamily: 'hubballi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            content: Text(
                              "Are you sure? It will be erase all your datas",
                              style: TextStyle(
                                  fontFamily: 'hubballi',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: blueShade),
                            ),
                          );
                        },
                      );
                    },
                    title: Text(
                      'Reset App',
                      style: TextStyle(
                          fontFamily: 'hubballi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blueShade),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text('Verison 1.0.0',style: TextStyle(color: Colors.grey),),
              )
            ],
          ),
        ));
  }
}

void resetApp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.clear();

  final categorydb = await Hive.openBox<CategoryModel>('category-database');

  categorydb.clear();

  final transactiondb = await Hive.openBox<TransactionModel>('transaction-db');

  transactiondb.clear();
}
