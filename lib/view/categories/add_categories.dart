import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/controller/category_db/category_db.dart';
import 'package:money_saver/controller/category_db/category_type_provider.dart';
import 'package:money_saver/models/category_model/category_model.dart';
import 'package:provider/provider.dart';
import '../../core/styles.dart';

//ValueNotifier<CategoryType> selectedCategoryNotifier =
//  ValueNotifier(CategoryType.income);

Future showCategoryPopup(BuildContext context,
    [CategoryType? categoryType]) async {
  final catgeoryNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        backgroundColor: bodyColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
        title: Text(
          'Add Your Category',
          style: TextStyle(
            fontFamily: 'hubballi',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: blueShade,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                RadioButton(
                  title: 'Income',
                  type: CategoryType.income,
                ),
                RadioButton(
                  title: 'Expense',
                  type: CategoryType.expense,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 10,
              controller: catgeoryNameController,
              style: TextStyle(
                  color: blueShade,
                  fontFamily: 'hubballi',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              cursorColor: blueShade,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: greenShade,
                    width: 2,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: 'Enter Category',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 30,
                height: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(greenShade),
                  ),
                  onPressed: () {
                    final categoryName = catgeoryNameController.text;
                    if (categoryName.isEmpty) {
                      return;
                    }
                    final type = Provider.of<CategoryTypeProvider>(context,listen: false).selectedCatgoryProvider;
                    final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: categoryName,
                      type: type,
                    );
                    context.read<CategoryProvider>().insertCategory(category);
                    //  CategoryDB.instance.insertCategory(notifierCategory);
                    Navigator.of(ctx).pop();
                    AnimatedSnackBar.material(
                      'Category added Successfully',
                      borderRadius: BorderRadius.circular(20),
                      type: AnimatedSnackBarType.success,
                      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                      duration: const Duration(
                        seconds: 4,
                      ),
                    ).show(context);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: whiteShade,
                        fontFamily: 'hubballi',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<CategoryTypeProvider>(
          // valueListenable: selectedCategoryNotifier,
          builder: (context, newCategory, child) {
            return Radio<CategoryType>(
              fillColor: MaterialStatePropertyAll(greenShade),
              value: type,
              groupValue: newCategory.selectedCatgoryProvider,
              onChanged: (value) {
                context
                    .read<CategoryTypeProvider>()
                    .onChanging(value,newCategory);
              },
            );
          },
        ),
        Text(title)
      ],
    );
  }
}
