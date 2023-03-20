import 'package:lottie/lottie.dart';
import 'package:money_saver/core/styles.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';


// ValueNotifier<List<TransactionModel>> graphNotifier =
//     ValueNotifier(TransactionDb.instance.transactionListNotifier.value);

class AllInsights extends StatelessWidget {
  AllInsights({super.key});

  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  // @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyColor,
        body: Consumer<TransactionProvider>(
          //valueListenable: graphNotifier,
          builder: (context, value, child) {
            Map incomeMap = {
              'name': 'Income',
              "amount": value.incomeTotal,
            };
            Map expenseMap = {
              "name": "Expense",
              "amount": value.expenseTotal,
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            return value.overviewGraphTransaction.isEmpty
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
                      backgroundColor: Colors.transparent,
                      palette: <Color>[
                        incomeColor,
                        expenseColor,
                      ],
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        DoughnutSeries<Map, String>(
                          innerRadius: '100',
                          legendIconType: LegendIconType.seriesType,
                          selectionBehavior: SelectionBehavior(
                            enable: true,
                            selectedColor: Colors.blue,
                          ),
                          radius: '160',
                          enableTooltip: true,
                          dataSource: totalMap,
                          xValueMapper: (Map data, _) => data['name'],
                          yValueMapper: (Map data, _) => data['amount'],
                          dataLabelSettings: const DataLabelSettings(
                            textStyle: TextStyle(
                              fontFamily: 'hubballi',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            isVisible: true,
                          ),
                        )
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
                        isVisible: true,

                        //  offset: Offset(5,5)
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
