import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../db_functions/category_db/category_db.dart';
import '../../models/category_model/category_model.dart';
import '../../styles/styles.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryListListener,
      builder: ((BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        final temp = newList.reversed.toList();
        final newReversedList = temp.toSet().toList();
        return newReversedList.isEmpty
            ? Center(child: Lottie.asset('assets/nodatafound.json', width: 150))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: newReversedList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: ((
                    context,
                    index,
                  ) {
                    final category = newReversedList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: .5,
                                  blurRadius: 1,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                  offset: Offset(3, 3))
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color:const Color.fromARGB(210, 225, 253, 188)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 25,
                                color: blueShade,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        backgroundColor: bodyColor,
                                        title: const Text(
                                          'ALERT!',
                                          style: TextStyle(
                                              fontFamily: 'hubballi',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        content: Text(
                                          'Do you want to Delete.',
                                          style: TextStyle(
                                              fontFamily: 'hubballi',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: blueShade),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: (() {
                                                CategoryDB().deleteCategory(
                                                  category.id,
                                                );
                                                Navigator.of(context).pop();
                                                AnimatedSnackBar.material(
                                                  'Category Deleted Successfully',
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  type: AnimatedSnackBarType
                                                      .success,
                                                  mobileSnackBarPosition:
                                                      MobileSnackBarPosition
                                                          .bottom,
                                                  duration: const Duration(
                                                    seconds: 4,
                                                  ),
                                                ).show(context);
                                              }),
                                              child: const Text(
                                                'yes',
                                                style: TextStyle(
                                                    fontFamily: 'hubballi',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.redAccent),
                                              )),
                                          TextButton(
                                              onPressed: (() {
                                                Navigator.of(context).pop();
                                              }),
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    fontFamily: 'hubballi',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: blueShade),
                                              ))
                                        ],
                                      );
                                    }));
                              },
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(category.name,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: blueShade,
                                              fontFamily: 'hubballi',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
      }),
    );
  }
}
