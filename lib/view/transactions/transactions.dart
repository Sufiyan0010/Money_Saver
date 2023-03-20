import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/transactions/slidable.dart';
import 'package:money_saver/models/category_model/category_model.dart';
import 'package:provider/provider.dart';
import '../../models/transactions_model/transaction_model.dart';

// ValueNotifier<List<TransactionModel>> overViewNotifier =
//     ValueNotifier(TransactionDb.instance.transactionListNotifier.value);

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    // TransactionDb.instance.refresh();

    return Consumer<TransactionProvider>(
      builder: (context, newList, _) {
        var displayList = [];
        if (newList.showCategory == 'Income') {
          List<TransactionModel> incomeTransactionList = [];
          incomeTransactionList = newList.overviewTransaction
              .where((element) => element.type == CategoryType.income)
              .toList();
          displayList = incomeTransactionList;
        } else if (newList.showCategory == 'Expense') {
          List<TransactionModel> expenseTransactionList = [];
          expenseTransactionList = newList.overviewTransaction
              .where((element) => element.type == CategoryType.expense)
              .toList();
          displayList = expenseTransactionList;
        } else {
          displayList = newList.overviewTransaction;
        }
        return displayList.isEmpty
            ? Center(child: Lottie.asset('assets/nodatafound.json', width: 200))
            : ListView.separated(
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final transaction = displayList[index];
                  return SlidableTile(
                    transaction: transaction,
                  );
                },
              );
      },
    );
  }
}
