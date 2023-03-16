import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_saver/models/category_model/category_model.dart';



abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategory();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions{
  String categoryDbName = 'category-database';
  CategoryDB.internal();

  static CategoryDB instance = CategoryDB.internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categorydb = await Hive.openBox<CategoryModel>(categoryDbName);
    await categorydb.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final categorydb = await Hive.openBox<CategoryModel>(categoryDbName);
    return categorydb.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategory = await getCategory();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    Future.forEach(
      allCategory,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categorydb = await Hive.openBox<CategoryModel>(categoryDbName);
    categorydb.delete(categoryID);
    refreshUI();
  }
}
