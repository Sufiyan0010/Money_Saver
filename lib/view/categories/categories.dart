import 'package:flutter/material.dart';
import 'package:money_saver/controller/category_db/category_db.dart';
import 'package:money_saver/view/categories/expense.dart';
import 'package:money_saver/view/categories/income.dart';
import 'package:provider/provider.dart';

import '../../core/styles.dart';
import 'add_categories.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Provider.of<CategoryProvider>(context, listen: false).refreshUI());
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: bodyColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Categories',
              style: TextStyle(
                fontFamily: 'hubballi',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: whiteShade,
              ),
            ),
            backgroundColor: greenShade,
            elevation: 10,
            bottom: TabBar(
                isScrollable: false,
                labelColor: whiteShade,
                labelStyle: const TextStyle(
                  fontFamily: 'hubballi',
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'hubballi',
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
                splashBorderRadius: BorderRadius.circular(20),
                indicatorColor: bodyColor,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: 'INCOME'),
                  Tab(text: 'EXPENSE'),
                ]),
          ),
          body: const TabBarView(children: [
            IncomeScreen(),
            ExpenseScreen(),
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showCategoryPopup(context);
            },
            backgroundColor: greenShade,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            splashColor: Colors.black,
            child: Icon(
              Icons.add,
              size: 35,
              color: whiteShade,
            ),
          ),
        ));
  }
}
