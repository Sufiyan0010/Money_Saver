import 'package:flutter/material.dart';

import '../../../core/styles.dart';
import '../all_transactions.dart';

class TypeFilter extends StatefulWidget {
  const TypeFilter({super.key});

  @override
  State<TypeFilter> createState() => _TypeFilterState();
}

class _TypeFilterState extends State<TypeFilter> {
  @override
  void dispose() {
    showCategory.value = 'All';

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        itemBuilder: ((context) => [
              PopupMenuItem(
                value: 1,
                onTap: () => showCategory.value = 'All',
                child: Text('All',
                    style: TextStyle(
                        fontFamily: 'hubballi',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: blueShade)),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () => showCategory.value = 'Income',
                child: const Text('Income',
                    style: TextStyle(
                        fontFamily: 'hubballi',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),
              PopupMenuItem(
                value: 3,
                onTap: () => showCategory.value = 'Expense',
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
}
