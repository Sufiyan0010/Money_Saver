import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/category_model/category_model.dart';

abstract class TransactionDbfunctions {
  Future<void> addTransaction(TransactionModel obj);

  Future<List<TransactionModel>> getAllTransactions();

  Future<void> deleteTransaction(TransactionModel obj);

  Future<void> editTransaction(TransactionModel value);
}

class TransactionDb implements TransactionDbfunctions {
  String transactionDBName = 'transaction-db';
  TransactionDb.internal();

  static TransactionDb instance = TransactionDb.internal();
  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactiondb.put(obj.id, obj);
    refresh();
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    list.sort(
        (firstDate, secondDate) => secondDate.date.compareTo(firstDate.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    return transactiondb.values.toList();
  }

  @override
  Future<void> deleteTransaction(TransactionModel obj) async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactiondb.delete(obj.id);
    refresh();
  }

  @override
  Future<void> editTransaction(TransactionModel value) async {
    final transactiondb =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactiondb.put(value.id, value);
    refresh();
  }

  Future<void> resetApp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    final categoryDB = await Hive.openBox<CategoryModel>('category-database');

    categoryDB.clear();

    final transactiondb =
        await Hive.openBox<TransactionModel>('Transaction-database');

    transactiondb.clear();
    
  }
}
