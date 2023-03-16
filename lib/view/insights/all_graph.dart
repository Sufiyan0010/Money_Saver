import 'package:lottie/lottie.dart';
import 'package:money_saver/controller/total_balance.dart';
import 'package:money_saver/core/styles.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';

ValueNotifier<List<TransactionModel>> graphNotifier =
    ValueNotifier(TransactionDb.instance.transactionListNotifier.value);

class AllInsights extends StatefulWidget {
  const AllInsights({super.key});

  @override
  State<AllInsights> createState() => _AllInsightsState();
}

class _AllInsightsState extends State<AllInsights> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyColor,
        body: ValueListenableBuilder(
          valueListenable: graphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            Map incomeMap = {
              'name': 'Income',
              "amount": incomeTotal.value,
            };
            Map expenseMap = {
              "name": "Expense",
              "amount": expenseTotal.value,
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            return graphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:150),
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
