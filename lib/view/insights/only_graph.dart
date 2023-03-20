import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/core/styles.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OnlyGraph extends StatelessWidget {
   OnlyGraph({super.key, required});

  late TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
     _tooltipBehavior = TooltipBehavior(enable: true);
    return Consumer<TransactionProvider>(
      
      builder: ( context,  value,
           child) {
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
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100,right: 50),
                        //child: Lottie.asset('assets/incomedata.json'),
                        child: Text('No Data!',
                            style: TextStyle(
                              color: whiteShade,
                              fontFamily: 'hubballi',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 25),
                child: SfCircularChart(
                  title: ChartTitle(
                    text: 'Statistics',
                    textStyle: TextStyle(
                        fontFamily: 'hubballi',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: whiteShade),
                  ),
                  palette: <Color>[
                    incomeColor,
                    expenseColor,
                  ],
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<Map, String>(
                      // innerRadius: '80',
                      legendIconType: LegendIconType.seriesType,
                      selectionBehavior: SelectionBehavior(
                        enable: true,
                        selectedColor: Colors.blue,
                      ),
                      radius: '70',
                      enableTooltip: true,
                      dataSource: totalMap,
                      xValueMapper: (Map data, _) => data['name'],
                      yValueMapper: (Map data, _) => data['amount'],

                      dataLabelSettings: const DataLabelSettings(
                        // margin: EdgeInsets.only(left:30),
                        textStyle: TextStyle(
                          fontFamily: 'hubballi',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        isVisible: true,

                        // labelPosition: ChartDataLabelPosition.outside
                      ),
                    )
                  ],
                  legend: Legend(
                    position: LegendPosition.bottom,
                    // // padding: 10,
                    textStyle: TextStyle(
                        fontFamily: 'hubballi',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: whiteShade),

                    iconHeight: 20,
                    itemPadding: 15,
                    // alignment: ChartAlignment.center,

                    isVisible: true,
                  ),
                ),
              );
      },
    );
  }
}
