import 'package:flutter/material.dart';
import 'package:money_saver/models/category_model/category_model.dart';

class CategoryTypeProvider extends ChangeNotifier {
  CategoryType selectedCatgoryProvider = CategoryType.income;

  onChanging(value,CategoryTypeProvider newCatgory) {
    if (value == null) {
      return;
    }
    newCatgory.selectedCatgoryProvider = value;
    notifyListeners();
  }
}
