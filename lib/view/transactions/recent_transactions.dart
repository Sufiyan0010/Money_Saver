import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/transactions/slidable.dart';
import 'package:provider/provider.dart';
import 'add_transaction/add_transactions.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    // TransactionDb.instance.refresh();
    context.read<TransactionProvider>().refresh();
    return Consumer<TransactionProvider>(
        //valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (context, newList, _) {
      return newList.transactionListProvider.isEmpty
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
                                builder: (context) => const AddTransastion()),
                            // ).whenComplete(() {
                            //   setState(() {
                            //     incomeAndExpense();
                            //   });
                            // });
                          );
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
              itemCount: newList.transactionListProvider.length > 5
                  ? 5
                  : newList.transactionListProvider.length,
              itemBuilder: (context, index) {
                final transaction = newList.transactionListProvider[index];

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
