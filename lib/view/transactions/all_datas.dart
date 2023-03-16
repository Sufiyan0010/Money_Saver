// import 'package:flutter/material.dart';
// import 'package:money_saver/models/transactions_model/transaction_model.dart';

// import '../../styles/styles.dart';

// class AllDatas extends StatelessWidget {
//   final TransactionModel transaction;
//   const AllDatas(this.transaction, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteShade,
//       appBar: AppBar(
//         elevation: 20,
//         backgroundColor: greenShade,
//         centerTitle: true,
//         title: Text(
//           'Transaction',
//           style: TextStyle(
//               fontFamily: 'hubballi',
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: whiteShade),
//         ),
//       ),
//       body: Column(
//         //  mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left:15),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 1 / 10,
//               child: Row(
//                 children: [
//                   Text('Amount :',
//                       style: TextStyle(
//                           color: blueShade,
//                           fontFamily: 'hubballi',
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold)),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(transaction.amount.toString(),
//                         style: TextStyle(
//                             color: blueShade,
//                             fontFamily: 'hubballi',
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left:15),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 1 / 10,
//               child: Row(
//                 children: [
//                   Text('Category :',
//                       style: TextStyle(
//                           color: blueShade,
//                           fontFamily: 'hubballi',
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold)),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(transaction.category.name,
//                         style: TextStyle(
//                             color: blueShade,
//                             fontFamily: 'hubballi',
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left:15.0),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 1 / 10,
//              // width: MediaQuery.of(context).size.width * 10 / 10,
//               child: Row(
//                 children: [
//                   Text('Date :',
//                       style: TextStyle(
//                           color: blueShade,
//                           fontFamily: 'hubballi',
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold)),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(transaction.date.toString(),
//                         style: TextStyle(
//                             color: blueShade,
//                             fontFamily: 'hubballi',
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Text('Purpose :',
//                 style: TextStyle(
//                     color: blueShade,
//                     fontFamily: 'hubballi',
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold)),
//             title: Padding(
//               padding: const EdgeInsets.all(13),
//               child: Text(transaction.purpose,
//                   style: TextStyle(
//                       color: blueShade,
//                       fontFamily: 'hubballi',
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
