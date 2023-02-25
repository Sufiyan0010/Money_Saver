import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_saver/db_functions/transactions_db/transaction_db.dart';
import 'package:money_saver/home/transactions/all_transactions.dart';
import 'package:money_saver/home/transactions/slidable.dart';
import 'package:money_saver/models/category_model/category_model.dart';
import '../../models/transactions_model/transaction_model.dart';


ValueNotifier<List<TransactionModel>> overViewNotifier =
    ValueNotifier(TransactionDb.instance.transactionListNotifier.value);

class Transactions extends StatelessWidget {
  const Transactions({super.key});


  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    
   
    return ValueListenableBuilder(
        valueListenable: overViewNotifier,
        builder: (BuildContext con, List<TransactionModel> newList, Widget? _) {
          return ValueListenableBuilder(
            valueListenable: showCategory,
            builder: (context, showCategoryList, child) {
              var displayList = [];
              if (showCategory.value == 'Income') {
                List<TransactionModel> incomeTransactionList = [];
                incomeTransactionList = newList
                    .where((element) => element.type == CategoryType.income)
                    .toList();
                displayList = incomeTransactionList;
              } else if (showCategory.value == 'Expense') {
                List<TransactionModel> expenseTransactionList = [];
                expenseTransactionList = newList
                    .where((element) => element.type == CategoryType.expense)
                    .toList();
                displayList = expenseTransactionList;
              } else {
                displayList = newList;
              }
              return displayList.isEmpty
                  ?  Center(
                      child:Lottie.asset('assets/nodatafound.json',width: 200)
                    )
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
        });
  }
}
