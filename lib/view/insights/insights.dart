import 'package:flutter/material.dart';

import 'package:money_saver/view/insights/all_graph.dart';
import 'package:money_saver/view/insights/expense_graph.dart';
import 'package:money_saver/view/insights/income_graph.dart';

import '../../core/styles.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: bodyColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Statistics',
              style: TextStyle(
                fontFamily: 'hubballi',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: whiteShade,
              ),
            ),
            backgroundColor: greenShade,
            elevation: 0,
            bottom: TabBar(
                labelColor: whiteShade,
                labelStyle: const TextStyle(
                  fontFamily: 'hubballi',
                  fontWeight: FontWeight.bold,
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
                indicatorWeight: 5,
               indicatorSize:TabBarIndicatorSize.label ,
                automaticIndicatorColorAdjustment: true,
                tabs: const [
                  Tab(text: 'ALL'),
                  Tab(text: 'INCOME'),
                  Tab(text: 'EXPENSE')
                ]),
          ),
          body: const TabBarView(children: [
            AllInsights(),
            IncomeGraph(),
            ExpenseGraph(),
          ]),
        ));
  }
}
