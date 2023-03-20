import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:provider/provider.dart';
import '../../../controller/category_db/category_db.dart';
import '../../../core/styles.dart';
import 'widgets/fields.dart';

class AddTransastion extends StatelessWidget {
  const AddTransastion({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Provider.of<CategoryProvider>(context, listen: false).refreshUI());

    Provider.of<TransactionProvider>(context, listen: false).refresh();
  
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
        children:  [
          Fields(),
        ],
      ),
    );
  }
}
