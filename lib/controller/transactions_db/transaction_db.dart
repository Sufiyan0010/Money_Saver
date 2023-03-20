import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';
import '../../models/category_model/category_model.dart';

class TransactionProvider extends ChangeNotifier {
  // Future<void> addTransaction(TransactionModel obj);

  // Future<List<TransactionModel>> getAllTransactions();

  // Future<void> deleteTransaction(TransactionModel obj);

  // Future<void> editTransaction(TransactionModel value);
  double incomeTotal = 0;
  double expenseTotal = 0;
  double totalBalance = 0;
  String transactionDBName = 'transaction-db';
  String showCategory = ('All');
  String dateFilterTitle = "All";
  List<TransactionModel> transactionListProvider = [];
  List<TransactionModel> overviewGraphTransaction = [];
  List<TransactionModel> overviewTransaction = [];

  set setOverviewTransactions(List<TransactionModel> overViewNewList) {
    overviewTransaction = overViewNewList;
    notifyListeners();
  }

  set setOverViewGraphTransactions(
      List<TransactionModel> overViewGraphTransactionsNewList) {
    overviewGraphTransaction = overViewGraphTransactionsNewList;
    notifyListeners();
  }

  set setDateFilterTitle(String dateFilterTitleNewList) {
    dateFilterTitle = dateFilterTitleNewList;

    notifyListeners();
  }

  set setShowCategory(String overShowCategory) {
    showCategory = overShowCategory;
    notifyListeners();
  }

  set setTransactionListNotifier(List<TransactionModel> transactionNewList) {
    transactionListProvider = transactionNewList;
    notifyListeners();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    return transactiondb.values.toList();
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    list.sort(
        (firstDate, secondDate) => secondDate.date.compareTo(firstDate.date));
    transactionListProvider.clear();
    transactionListProvider.addAll(list);
    overviewTransaction = transactionListProvider;
    overviewGraphTransaction = transactionListProvider;
    incomeAndExpense();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel obj) async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactiondb.put(obj.id, obj);
    refresh();
  }

  Future<void> deleteTransaction(TransactionModel obj) async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactiondb.delete(obj.id);
    refresh();
  }

  Future<void> editTransaction(TransactionModel value) async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactiondb.put(value.id, value);
    refresh();
  }

  void incomeAndExpense() {
    incomeTotal = 0;
    expenseTotal = 0;
    totalBalance = 0;
    final List<TransactionModel> value = transactionListProvider;


      for (int i = 0; i < value.length; i++) {
      if (CategoryType.income == value[i].category.type) {
        incomeTotal = incomeTotal + value[i].amount;
      } else {
        expenseTotal = expenseTotal + value[i].amount;
      }
    }
    totalBalance = incomeTotal - expenseTotal;

    notifyListeners();
  }
  }


// class TransactionDb implements TransactionDbfunctions {
//   TransactionDb.internal();

//   static TransactionDb instance = TransactionDb.internal();
//   factory TransactionDb() {
//     return instance;
//   }

//   ValueNotifier<List<TransactionModel>> transactionListNotifier =
//       ValueNotifier([]);

//   @override
//   Future<void> addTransaction(TransactionModel obj) async {
//     final transactiondb =
//         await Hive.openBox<TransactionModel>(transactionDBName);
//     await transactiondb.put(obj.id, obj);
//     refresh();
//   }

//   Future<void> refresh() async {
//     final list = await getAllTransactions();
//     list.sort(
//         (firstDate, secondDate) => secondDate.date.compareTo(firstDate.date));
//     transactionListNotifier.value.clear();
//     transactionListNotifier.value.addAll(list);
//     transactionListNotifier.notifyListeners();
//   }

//   @override
//   Future<List<TransactionModel>> getAllTransactions() async {
//     final transactiondb =
//         await Hive.openBox<TransactionModel>(transactionDBName);
//     return transactiondb.values.toList();
//   }

//   @override
//   Future<void> deleteTransaction(TransactionModel obj) async {
//     final transactiondb =
//         await Hive.openBox<TransactionModel>(transactionDBName);
//     await transactiondb.delete(obj.id);
//     refresh();
//   }

//   @override
//   Future<void> editTransaction(TransactionModel value) async {
//     final transactiondb =
//         await Hive.openBox<TransactionModel>(transactionDBName);
//     await transactiondb.put(value.id, value);
//     refresh();
//   }

//   Future<void> resetApp() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.clear();

//     final categoryDB = await Hive.openBox<CategoryModel>('category-database');

//     categoryDB.clear();

//     final transactiondb =
//         await Hive.openBox<TransactionModel>('Transaction-database');

//     transactiondb.clear();
//   }
// }
