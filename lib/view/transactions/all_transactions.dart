import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/transactions/filters/date_filter.dart';
import 'package:money_saver/view/transactions/filters/type_filter.dart';
import 'package:money_saver/view/transactions/search/search.dart';

import 'package:money_saver/view/transactions/transactions.dart';

import '../../core/styles.dart';

ValueNotifier showCategory = ValueNotifier('All');

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  


  
  @override
  void initState() {
    overViewNotifier.value =
        TransactionDb.instance.transactionListNotifier.value;
    TransactionDb.instance.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: greenShade,
        centerTitle: true,
        title: Text(
          'All Transactions',
          style: TextStyle(
              fontFamily: 'hubballi',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: whiteShade),
        ),
        actions: const [
          TypeFilter(),
          SizedBox(
            width: 15,
          ),
          DatesFilter(),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          SearchField(),
          const Expanded(
            child: Transactions(),
          )
        ],
      ),
    );
  }
}
