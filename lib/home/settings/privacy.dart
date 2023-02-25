import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Terms and Conditions',
          style: TextStyle(
              fontFamily: 'hubballi',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: whiteShade),
        ),
        backgroundColor: greenShade,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Introduction',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'Welcome to the terms and conditions of Money Saver money manager app for offline use. By downloading and using this app, you agree to the terms and conditions outlined in this document. These terms and conditions are a legal agreement between you  and Money Saver.',
            ),
             SizedBox(height: 16.0),
            Text(
              '1. Ownership and Use:',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'Money Saver owns all rights, titles, and interests in the app, including all intellectual property rights. You are granted a non-exclusive, non-transferable, limited license to use the app solely for your personal, non-commercial use.',
            ),
             SizedBox(height: 16.0),
            Text(
              '2. Appropriate Use:',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'You agree to use the app in a manner that complies with all applicable laws, regulations, and industry standards. You also agree not to use the code for any illegal or unauthorized purposes.',
            ),
             SizedBox(height: 16.0),
            Text(
              '3.Limitations of Liability:',
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'Money Saver is not liable for any damages arising from the use of the app, including direct, indirect, incidental, consequential, special, or punitive damages. This limitation of liability applies regardless of the cause of action, whether in contract, tort, or otherwise.',
            ),
             SizedBox(height: 16.0),
            Text(
              '4.Indemnification:',
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'You agree to indemnify and hold Money Saver harmless from any and all claims, damages, expenses, and liabilities, including reasonable attorneys fees, arising from your use of the app or your breach of these terms and conditions.',
            ),
             SizedBox(height: 16.0),
            Text(
              '5.Termination:',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'Money Saver may terminate your access to the app at any time without notice, for any reason. Upon termination, you must immediately delete the app from all devices and destroy all copies of the app in your possession.',
            ),
             SizedBox(height: 16.0),
            Text(
              '6.Governing Law:',
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'These terms and conditions are governed by and construed in accordance with the laws of [insert governing law]. Any dispute arising from or related to these terms and conditions shall be resolved exclusively in the courts of [insert jurisdiction].',
            ),
             SizedBox(height: 16.0),
            Text(
              '7.Changes to Terms and Conditions:',
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'Maoney Saver reserves the right to modify these terms and conditions at any time without notice. Your continued use of the app after any such modifications constitutes your acceptance of the modified terms and conditions.',
            ),
             SizedBox(height: 16.0),
           Text(
              'Conclusion:',
              style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500  ),
            ),
             SizedBox(height: 8.0),
             Text(
              'Thank you for reading these terms and conditions. If you have any questions or concerns, please contact us .',
            ),
          ],
        ),
      ),
    );
  }
}
