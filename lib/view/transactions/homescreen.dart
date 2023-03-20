import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/insights/only_graph.dart';
import 'package:money_saver/view/transactions/add_transaction/add_transactions.dart';
import 'package:money_saver/view/transactions/all_transactions.dart';
import 'package:money_saver/view/transactions/recent_transactions.dart';
import 'package:money_saver/core/styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGraph = false;
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     incomeAndExpense();
  //     graphNotifier.value =
  //         TransactionDb.instance.transactionListNotifier.value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // CategoryDB.instance.refreshUI();
    // TransactionDb.instance.refresh();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<TransactionProvider>().overviewGraphTransaction =
            context.read<TransactionProvider>().transactionListProvider;
      },
    );

    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Money Saver',
          style: TextStyle(
              fontFamily: 'hubballi',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: whiteShade),
        ),
        backgroundColor: greenShade,
        elevation: 10,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Stack(
              children: [
                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 3 / 10,
                      width: MediaQuery.of(context).size.width * 8.5 / 10,
                      decoration: BoxDecoration(
                        color: blueShade,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: !isGraph
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 30,
                              ),
                              child: Consumer<TransactionProvider>(builder:
                                  (context, incomeAndExpenseProvider, child) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            incomeAndExpenseProvider
                                                        .totalBalance <
                                                    0
                                                ? 'Total Lose'
                                                : 'Total Balance',
                                            style: TextStyle(
                                              color: bodyColor,
                                              fontFamily: 'hubballi',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            incomeAndExpenseProvider
                                                        .totalBalance <
                                                    0
                                                ? '₹${incomeAndExpenseProvider.totalBalance.toString()}'
                                                : '₹${incomeAndExpenseProvider.totalBalance.toString()}',
                                            style: TextStyle(
                                              color: incomeAndExpenseProvider
                                                          .totalBalance <
                                                      0
                                                  ? expenseColor
                                                  : incomeColor,
                                              fontFamily: 'hubballi',
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor: whiteShade,
                                                  child: const Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.green,
                                                    size: 22,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text(
                                                  'Income',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 22,
                                                    fontFamily: 'hubballi',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '₹${incomeAndExpenseProvider.incomeTotal}',
                                              style: TextStyle(
                                                color: bodyColor,
                                                fontFamily: 'hubballi',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor: whiteShade,
                                                  child: const Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.red,
                                                    size: 22,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text(
                                                  'Expense',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 22,
                                                    fontFamily: 'hubballi',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '₹${incomeAndExpenseProvider.expenseTotal.toString()}',
                                              style: TextStyle(
                                                color: bodyColor,
                                                fontFamily: 'hubballi',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: OnlyGraph(),
                            )),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isGraph = !isGraph;
                      });
                    },
                    icon: Icon(
                      Icons.bar_chart,
                      color: bodyColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      color: blueShade,
                      fontFamily: 'hubballi',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<TransactionProvider>(builder: (context, newList, _) {
                    return newList.transactionListProvider.isEmpty
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blueShade,
                              elevation: 0,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {},
                            child: Text(
                              'No Data!',
                              style: TextStyle(
                                color: whiteShade,
                                fontFamily: 'hubballi',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenShade,
                              elevation: 0,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const AllTransactions(),
                                      type: PageTransitionType.fade,
                                      duration:
                                          const Duration(milliseconds: 500)));
                            },
                            child: Text(
                              'View all',
                              style: TextStyle(
                                color: whiteShade,
                                fontFamily: 'hubballi',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ));
                  })
                ],
              )
            ]),
          ),
          const RecentTransactions(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransastion()),
          );
          // .whenComplete(() {
          //   setState(() {
          //     incomeAndExpense();
          //   });
          // });
        },
        backgroundColor: greenShade,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        splashColor: Colors.black,
        child: Icon(
          Icons.add,
          size: 30,
          color: whiteShade,
        ),
      ),
    );
  }
}
