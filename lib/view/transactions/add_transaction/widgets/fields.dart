import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_saver/controller/category_db/category_db.dart';
import 'package:money_saver/controller/transactions_db/add_transaction_provider.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/categories/add_categories.dart';
import 'package:money_saver/models/category_model/category_model.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles.dart';

class Fields extends StatefulWidget {
  const Fields({super.key});

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  final formKey = GlobalKey<FormState>();

  final amoutTextController = TextEditingController();

  final purposeTextController = TextEditingController();

  DateTime? selectedDate;

  CategoryType? selectedCategoryType;

  CategoryModel? selectedCategoryModel;

  String? categoryID;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TransactionDb.instance.refresh();
    // CategoryDB.instance.refreshUI();
    context.read<TransactionProvider>().refresh();
    context.read<CategoryProvider>().refreshUI();

    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<AddTransactionProvider>(
                builder: (context, provider, child) {
              return ChoiceChip(
                label: const Text(
                  'Income',
                ),
                backgroundColor: const Color.fromARGB(255, 205, 205, 205),
                selectedColor: incomeColor,
                selected: provider.value == 0,
                labelStyle: TextStyle(
                    color: blueShade,
                    fontFamily: 'hubballi',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                onSelected: (bool selected) {
                  provider.incomeChoiceChip();
                },
              );
            }),
            Consumer<AddTransactionProvider>(builder: (context, provider, _) {
              return ChoiceChip(
                label: const Text(
                  'Expense',
                ),
                backgroundColor: const Color.fromARGB(255, 205, 205, 205),
                selectedColor: expenseColor,
                selected: provider.value == 1,
                labelStyle: TextStyle(
                    color: blueShade,
                    fontFamily: 'hubballi',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                onSelected: (bool selected) {
                  provider.expenseChoiceChip();
                },
              );
            }),
          ],
        ),
        Text(
          'Category',
          style: TextStyle(
              color: blueShade,
              fontFamily: 'hubballi',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        categoryItems(context),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Amount',
          style: TextStyle(
              color: blueShade,
              fontFamily: 'hubballi',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        TextFormField(
          maxLength: 7,
          controller: amoutTextController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
          style: TextStyle(
              color: blueShade,
              fontFamily: 'hubballi',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          cursorColor: blueShade,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.attach_money_outlined,
              color: greenShade,
            ),
            hintText: 'Enter the Amount',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: greenShade,
                width: 2,
              ),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const Text(
          'Purpose',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'hubballi',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
          style: TextStyle(
              color: blueShade,
              fontFamily: 'hubballi',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.done,
          controller: purposeTextController,
          cursorColor: blueShade,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.notes,
              color: greenShade,
            ),
            hintText: 'Enter the Purpose',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: greenShade,
                width: 2,
              ),
            ),
            border: const OutlineInputBorder(),
          ),
          minLines: 3,
          maxLines: 3,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date',
              style: TextStyle(
                  color: blueShade,
                  fontFamily: 'hubballi',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: Consumer<AddTransactionProvider>(
                  builder: (context, value, child) {
                return TextButton.icon(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 2.0,
                      color: greenShade,
                    ),
                  ),
                  onPressed: () async {
                    final selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(
                          days: 30,
                        )),
                        lastDate: DateTime.now());
                    value.dateSelection(selectedDateTemp);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: greenShade,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      value.selectedDateTime == null
                          ? 'Select Date'
                          : parseDtaeTime(context
                              .watch<AddTransactionProvider>()
                              .selectedDateTime!),
                      style: TextStyle(
                          color: blueShade,
                          fontFamily: 'hubballi',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(greenShade),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                addTranssaction(context);
              }
            },
            icon: Icon(
              Icons.add,
              size: 20,
              color: whiteShade,
            ),
            label: Text(
              'Add',
              style: TextStyle(
                  color: whiteShade,
                  fontFamily: 'hubballi',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }

  Future addTranssaction(context) async {
    final purposeText = purposeTextController.text;
    final amountText = amoutTextController.text;
    final parsedAmount = double.tryParse(amountText);
    // if (purposeText.isEmpty ||
    //     amountText.isEmpty ||
    //     categoryID == null ||
    //     selectedDate == null ||
    //     selectedCategoryModel == null ||
    //     parsedAmount == null) {
    //   return;
    // }
    if (amountText.isEmpty) {
      return;
    }
    if (parsedAmount == null) {
      return;
    }
    if (Provider.of<AddTransactionProvider>(context, listen: false)
            .categoryId ==
        null) {
      return;
    }

    final modal = TransactionModel(
      purpose: purposeText,
      amount: parsedAmount,
      date: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedDateTime!,
      type: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedCategoryType!,
      category: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedCategoryModel!,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    // await TransactionDb.instance.addTransaction(modal);
    await Provider.of<TransactionProvider>(context, listen: false)
        .addTransaction(modal);
    navigationSnackBar(context);
    // clearTextField();
    //TransactionDb.instance.refresh();
  }

 

  navigationSnackBar(context) {
    Navigator.of(context).pop();
    AnimatedSnackBar.material(
      'Transaction Added Successfully',
      borderRadius: BorderRadius.circular(20),
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(
        seconds: 4,
      ),
    ).show(context);
  }

  String parseDtaeTime(DateTime date) {
    final dateFormatted = DateFormat.MMMMd().format(date);
    final splitDate = dateFormatted.split(' ');
    return "${splitDate.last}  ${splitDate.first} ";
  }

  Row categoryItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Consumer2<AddTransactionProvider, CategoryProvider>(
          // valueListenable: selectedCategoryType == CategoryType.income
          //   : CategoryDB().expenseCategoryListListener,
          builder: (context, tProvider, cProvider, child) {
            return DropdownButtonFormField(
              style: TextStyle(
                  overflow: TextOverflow.fade,
                  color: blueShade,
                  fontFamily: 'hubballi',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              validator: (value) {
                if (value == null) {
                  return 'Required';
                }
                return null;
              },
              decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenShade, width: 2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              elevation: 9,
              hint: Text(
                'select category',
                style: TextStyle(
                    overflow: TextOverflow.fade,
                    color: blueShade,
                    fontFamily: 'hubballi',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              value: tProvider.categoryId,
              items: (tProvider.selectedCategoryType == CategoryType.income
                      ? cProvider.incomeCategoryProvider
                      : cProvider.expenseCategoryProvider)
                  .map((e) {
                return DropdownMenuItem(
                  alignment: AlignmentDirectional.centerStart,
                  value: e.id,
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black38,
                      //   width: 1,
                      // ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      e.name,
                    ),
                  ),
                  onTap: () {
                    context.read<CategoryProvider>().refreshUI();
                    tProvider.selectedCategoryModel = e;
                  },
                );
              }).toList(),
              onChanged: ((selectedValue) {
                // print(selectedValue);
                tProvider.categoryId = selectedValue;
              }),
            );
          },
        )),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: greenShade,
            ),
            child: IconButton(
              onPressed: (() {
                showCategoryPopup(
                    context,
                    context
                        .read<AddTransactionProvider>()
                        .selectedCategoryType!);
                context.read<CategoryProvider>().expenseCategoryProvider;
                context.read<CategoryProvider>().incomeCategoryProvider;
                // CategoryDB.instance.expenseCategoryListListener
                //     .notifyListeners();
                // CategoryDB.instance.incomeCategoryListListener
                //     .notifyListeners();
              }),
              icon: Icon(
                Icons.add,
                color: whiteShade,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
