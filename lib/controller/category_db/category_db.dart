import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_saver/models/category_model/category_model.dart';

const categoryDbName = 'category-database';

//==========Category Provider Class==========\\
class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> incomeCategoryProvider = [];
  List<CategoryModel> expenseCategoryProvider = [];

  //==========Insert Function==========\\

  Future<void> insertCategory(CategoryModel value) async {
    final categorydb = await Hive.openBox<CategoryModel>(categoryDbName);
    await categorydb.put(value.id, value);
    refreshUI();
  }

  //==========Get Function==========\\

  Future<List<CategoryModel>> getCategory() async {
    final categorydb = await Hive.openBox<CategoryModel>(categoryDbName);

    notifyListeners();
    return categorydb.values.toList();
  }
  //=========Delete Function==========\\

  Future<void> deleteCategory(String categoryID) async {
    final categorydb = await Hive.openBox<CategoryModel>(categoryDbName);
    categorydb.delete(categoryID);
    refreshUI();
  }

  //=========Refresh Function==========\\

  Future<void> refreshUI() async {
    final allCategory = await getCategory();
    incomeCategoryProvider.clear();
    expenseCategoryProvider.clear();
    Future.forEach(
      allCategory,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryProvider.add(category);
        } else {
          expenseCategoryProvider.add(category);
        }
      },
    );

    notifyListeners();
  }
}

// class CategoryDB implements CategoryDbFunctions {
//   CategoryDB.internal();

//   static CategoryDB instance = CategoryDB.internal();

//   factory CategoryDB() {
//     return instance;
//   }

//   ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
//       ValueNotifier([]);
//   ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
//       ValueNotifier([]);

//   @override
  
//   @override
  



//   @override
 
// }
