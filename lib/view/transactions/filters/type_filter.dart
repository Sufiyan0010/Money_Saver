import 'package:flutter/material.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:provider/provider.dart';

import '../../../core/styles.dart';

class TypeFilter extends StatelessWidget {
  const TypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context,showCatgory,_) {
        return PopupMenuButton(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    value: 1,
                    onTap: () => showCatgory.setShowCategory = "All",
                    child: Text('All',
                        style: TextStyle(
                            fontFamily: 'hubballi',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: blueShade)),
                  ),
                  PopupMenuItem(
                    value: 2,
                    onTap: () => showCatgory.setShowCategory = 'Income',
                    child: const Text('Income',
                        style: TextStyle(
                            fontFamily: 'hubballi',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ),
                  PopupMenuItem(
                    value: 3,
                    onTap: () => showCatgory.setShowCategory = 'Expense',
                    child: const Text('Expense',
                        style: TextStyle(
                            fontFamily: 'hubballi',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                  ),
                ]),
            child: const Icon(
              Icons.checklist,
              size: 30,
              // shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 15.0)],
            ));
      }
    );
  }
}
