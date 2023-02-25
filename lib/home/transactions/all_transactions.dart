import 'package:flutter/material.dart';
import 'package:money_saver/db_functions/transactions_db/transaction_db.dart';
import 'package:money_saver/home/transactions/filters/date_filter.dart';
import 'package:money_saver/home/transactions/filters/type_filter.dart';
import 'package:money_saver/home/transactions/search/search.dart';

import 'package:money_saver/home/transactions/transactions.dart';

import '../../styles/styles.dart';

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
