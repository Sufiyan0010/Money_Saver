// import 'package:flutter/material.dart';
// import 'package:money_saver/controller/transactions_db/transaction_db.dart';
// import 'package:money_saver/models/category_model/category_model.dart';
// import 'package:money_saver/models/transactions_model/transaction_model.dart';

// ValueNotifier incomeTotal = ValueNotifier(0.0);
// ValueNotifier expenseTotal = ValueNotifier(0.0);
// ValueNotifier totalBlanace = ValueNotifier(0.0);
// void incomeAndExpense() {
  
//   incomeTotal.value = 0;
//   expenseTotal.value = 0;
//   totalBlanace.value = 0;
//   final List<TransactionModel> value =
//       TransactionDb.instance.transactionListNotifier.value;
//   for (int i = 0; i < value.length; i++) {
//     if (CategoryType.income == value[i].category.type) {
//       incomeTotal.value = incomeTotal.value + value[i].amount;
//     } else {
//       expenseTotal.value = expenseTotal.value + value[i].amount;
//     }
//   }
//   totalBlanace.value = incomeTotal.value - expenseTotal.value;
// }
