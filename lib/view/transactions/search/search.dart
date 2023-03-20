import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/core/styles.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 10,
        color: bodyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: TextField(
            cursorColor: blueShade,
            style: TextStyle(
                fontFamily: 'hubballi',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: blueShade),
            controller: searchController,
            onChanged: (result) {
              searchResult(result, context);
            },
            decoration: InputDecoration(
                hintText: 'Search Here',
                hintStyle: const TextStyle(
                    fontFamily: 'hubballi',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 153, 153, 153)),
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.blue,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    context.read<TransactionProvider>().overviewTransaction =
                        context
                            .read<TransactionProvider>()
                            .transactionListProvider;
                    context.read<TransactionProvider>().notifyListeners();

                    // overViewNotifier.value =
                    //     TransactionDb.instance.transactionListNotifier.value;
                    // searchController.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.red,
                  ),
                )),
          ),
        ),
      ),
    );
  }

  searchResult(String result, BuildContext context) {
    if (result.isEmpty) {
      context.read<TransactionProvider>().overviewTransaction =
          context.read<TransactionProvider>().transactionListProvider;
      context.read<TransactionProvider>().notifyListeners();

      // overViewNotifier.value =
      //     TransactionDb.instance.transactionListNotifier.value;
    } else {
      context.read<TransactionProvider>().overviewTransaction = context
          .read<TransactionProvider>()
          .overviewTransaction
          .where((element) =>
              element.category.name
                  .toLowerCase()
                  .contains(result.trim().toLowerCase()) ||
              element.purpose
                  .toLowerCase()
                  .contains(result.trim().toLowerCase()))
          .toList();
      context.read<TransactionProvider>().notifyListeners();
    }
  }
}
