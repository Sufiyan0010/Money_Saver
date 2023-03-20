import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';

import 'package:money_saver/view/transactions/edit_transaction/edit_transaction.dart';

import 'package:money_saver/models/transactions_model/transaction_model.dart';
import 'package:provider/provider.dart';

import '../../models/category_model/category_model.dart';
import '../../core/styles.dart';

class SlidableTile extends StatelessWidget {
  const SlidableTile({super.key, required this.transaction});

  final TransactionModel transaction;

  //==========DateFunction===============\\
  String parseDate(DateTime date) {
    final dateFormat = DateFormat.MMMd().format(date);
    final splitDate = dateFormat.split(' ');

    return '${splitDate.last} ${splitDate.first}';
  }

  @override
  Widget build(BuildContext context) {
    // TransactionDb.instance.refresh();
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: bodyColor,
            spacing: 10,
            onPressed: ((context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTransaction(
                      obj: transaction,
                    ),
                  ));
            }),
            icon: Icons.mode_edit_outline,
            foregroundColor: Colors.blue,
          ),
          SlidableAction(
            backgroundColor: bodyColor,
            onPressed: ((context) {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      title: const Text(
                        'ALERT!',
                        style: TextStyle(
                            fontFamily: 'hubballi',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      backgroundColor: bodyColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      content: Text(
                        'Do you want to Delete.',
                        style: TextStyle(
                            fontFamily: 'hubballi',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: blueShade),
                      ),
                      actions: [
                        TextButton(
                            onPressed: (() {
                              Provider.of<TransactionProvider>(context,
                                      listen: false)
                                  .deleteTransaction(transaction);
                              Navigator.of(context).pop();

                              AnimatedSnackBar.material(
                                'Transaction Deleted Successfully',
                                borderRadius: BorderRadius.circular(20),
                                type: AnimatedSnackBarType.success,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.bottom,
                                duration: const Duration(
                                  seconds: 4,
                                ),
                              ).show(context);
                            }),
                            child: const Text(
                              'yes',
                              style: TextStyle(
                                  fontFamily: 'hubballi',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            )),
                        TextButton(
                          onPressed: (() {
                            Navigator.of(context).pop();
                          }),
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontFamily: 'hubballi',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: blueShade),
                          ),
                        ),
                      ],
                    );
                  }));
            }),
            icon: Icons.delete_forever,
            foregroundColor: Colors.red,
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        color: whiteShade,
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: blueShade,
              radius: 18,
              child: Icon(
                transaction.type == CategoryType.income
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: transaction.type == CategoryType.income
                    ? incomeColor
                    : expenseColor,
                size: 22,
              )),
          title: Text(
            '₹${transaction.amount}',
            style: TextStyle(
              color: blueShade,
              fontFamily: 'hubballi',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            transaction.category.name,
            style: TextStyle(
              color: transaction.type == CategoryType.income
                  ? incomeColor
                  : expenseColor,
              fontFamily: 'hubballi',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            parseDate(transaction.date),
            style: TextStyle(
                fontFamily: 'hubballi',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: blueShade),
          ),
        ),
      ),
    );
  }
}
