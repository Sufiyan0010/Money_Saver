import 'package:flutter/material.dart';
import 'package:money_saver/models/category_model/category_model.dart';

class AddTransactionProvider extends ChangeNotifier {
  CategoryModel? selectedCategoryModel;
  CategoryType? selectedCategoryType = CategoryType.income;
  DateTime? selectedDateTime; 
  int value = 0;
  String? categoryId;

  incomeChoiceChip() {
    value = 0;
    selectedCategoryType = CategoryType.income;
    categoryId = null;
    notifyListeners();
  }

  expenseChoiceChip() {
    value = 1;
    selectedCategoryType = CategoryType.expense;
    categoryId = null;
    notifyListeners();
  }

  dateSelection(DateTime? selectedDateTemp) {
    if (selectedDateTemp == null) {
      selectedDateTime = DateTime.now();
      notifyListeners();
    } else {
      selectedDateTime = selectedDateTemp;
      notifyListeners();
    }
    notifyListeners();
  }
}
