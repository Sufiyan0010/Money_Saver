import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/models/category_model/category_model.dart';
import 'package:money_saver/core/styles.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/transactions_model/transaction_model.dart';

class ExpenseGraph extends StatelessWidget {
  const ExpenseGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyColor,
        body: Consumer<TransactionProvider>(
          builder: (context, value, child) {
            var allExpense = value.overviewGraphTransaction
                .where((element) => element.type == CategoryType.expense)
                .toList();
            return allExpense.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Lottie.asset('assets/socialnodata.json',
                                width: 200),
                          )
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        DoughnutSeries<TransactionModel, String>(
                            innerRadius: '100',
                            legendIconType: LegendIconType.seriesType,
                            selectionBehavior: SelectionBehavior(
                              enable: true,
                              selectedColor: Colors.blue,
                            ),
                            radius: '160',
                            enableTooltip: true,
                            dataSource: allExpense,
                            xValueMapper: (TransactionModel expenseData, _) =>
                                expenseData.category.name,
                            yValueMapper: (TransactionModel expenseData, _) =>
                                expenseData.amount,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                fontFamily: 'hubballi',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ))
                      ],
                      legend: Legend(
                        textStyle: const TextStyle(
                          fontFamily: 'hubballi',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        iconWidth: 20,
                        iconHeight: 18,
                        itemPadding: 25,
                        alignment: ChartAlignment.center,
                        shouldAlwaysShowScrollbar: true,
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
