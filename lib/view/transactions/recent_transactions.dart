import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/transactions/slidable.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';
import '../../controller/total_balance.dart';
import 'add_transaction/add_transactions.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return newList.isEmpty
              ? Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddTransastion()),
                              ).whenComplete(() {
                                setState(() {
                                  incomeAndExpense();
                                });
                              });
                            },
                            child: Lottie.asset('assets/nodatapreviwe.json',
                                width: 240)),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  itemCount: newList.length > 5 ? 5 : newList.length,
                  itemBuilder: (context, index) {
                    final transaction = newList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: SlidableTile(transaction: transaction),
                    );
                  });
        });
  }
}
