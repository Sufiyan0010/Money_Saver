import 'package:flutter/material.dart';
import 'package:money_saver/db_functions/category_db/category_db.dart';
import 'package:money_saver/db_functions/transactions_db/transaction_db.dart';

import '../../../styles/styles.dart';
import 'widgets/fields.dart';

class AddTransastion extends StatelessWidget {
  const AddTransastion({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        elevation: 20,
        backgroundColor: greenShade,
        centerTitle: true,
        title: Text(
          'Add Transaction',
          style: TextStyle(
              fontFamily: 'hubballi',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: whiteShade),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Fields(),
        ],
      ),
    );
  }
}
