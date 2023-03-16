import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/transactions/transactions.dart';

import '../../../core/styles.dart';

class DatesFilter extends StatefulWidget {
  const DatesFilter({super.key});

  @override
  State<DatesFilter> createState() => _DatesFilterState();
}

class _DatesFilterState extends State<DatesFilter> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.calendar_month,
        size: 25,
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          onTap: () {
            overViewNotifier.value =
                TransactionDb.instance.transactionListNotifier.value;
          },
          value: 1,
          child: Text('All',
              style: TextStyle(
                  fontFamily: 'hubballi',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: blueShade)),
        ),
        PopupMenuItem(
          onTap: () {
            overViewNotifier.value =
                TransactionDb.instance.transactionListNotifier.value;
            overViewNotifier.value = overViewNotifier.value
                .where((element) =>
                    element.date.day == DateTime.now().day &&
                    element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year)
                .toList();
          },
          value: 2,
          child: Text('Today',
              style: TextStyle(
                  fontFamily: 'hubballi',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: blueShade)),
        ),
        PopupMenuItem(
          onTap: () {
            overViewNotifier.value =
                TransactionDb.instance.transactionListNotifier.value;
            overViewNotifier.value = overViewNotifier.value
                .where((element) =>
                    element.date.day == DateTime.now().day - 1 &&
                    element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year)
                .toList();
          },
          value: 3,
          child: Text('Yestraday',
              style: TextStyle(
                  fontFamily: 'hubballi',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: blueShade)),
        ),
        PopupMenuItem(
          onTap: () {
            overViewNotifier.value =
                TransactionDb.instance.transactionListNotifier.value;
            overViewNotifier.value = overViewNotifier.value
                .where((element) =>
                    element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year)
                .toList();
          },
          value: 2,
          child: Text("This Month",
              style: TextStyle(
                  fontFamily: 'hubballi',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: blueShade)),

          // onTap: () {
          //   DateTime startDate = DateTime(2023, 2, 1);
          //   DateTime endDate = DateTime(2023, 2, 10);
          //   overViewNotifier.value =
          //       TransactionDb.instance.transactionListNotifier.value;
          //   overViewNotifier.value = overViewNotifier.value
          //       .where((element) =>
          //           element.date.isAfter(startDate) &&
          //           element.date.isBefore(endDate))
          //       .toList();
          // },
          // value: 2,
          // child: Text('Month',style: TextStyle(
          //         fontFamily: 'hubballi',
          //         fontSize: 25,
          //         fontWeight: FontWeight.bold,
          //         color: blueShade)),
        ),
      ],
    );
  }
}
