import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';
import 'package:money_saver/view/categories/add_categories.dart';

import 'package:money_saver/models/category_model/category_model.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';

import '../../../../controller/category_db/category_db.dart';
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
  int _value = 0;

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChoiceChip(
              label: const Text(
                'Income',
              ),
              backgroundColor: const Color.fromARGB(255, 205, 205, 205),
              selectedColor: incomeColor,
              selected: _value == 0,
              labelStyle: TextStyle(
                  color: blueShade,
                  fontFamily: 'hubballi',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              onSelected: (bool selected) {
                setState(() {
                  _value = 0;
                  selectedCategoryType = CategoryType.income;
                  categoryID = null;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Expense',
              ),
              backgroundColor: const Color.fromARGB(255, 205, 205, 205),
              selectedColor: expenseColor,
              selected: _value == 1,
              labelStyle: TextStyle(
                  color: blueShade,
                  fontFamily: 'hubballi',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              onSelected: (bool selected) {
                setState(() {
                  _value = 1;
                  selectedCategoryType = CategoryType.expense;
                  categoryID = null;
                });
              },
            ),
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
              child: TextButton.icon(
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
                  if (selectedDateTemp == null) {
                    return;
                  } else {
                    setState(() {
                      selectedDate = selectedDateTemp;
                    });
                  }
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: greenShade,
                ),
                label: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : parseDtaeTime(selectedDate!),
                    style: TextStyle(
                        color: blueShade,
                        fontFamily: 'hubballi',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
              if (selectedDate == null) {
                setState(() {
                  selectedDate = DateTime.now();
                });
              }

              if (formKey.currentState!.validate()) {
                addTranssaction();
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

  Future addTranssaction() async {
    final purposeText = purposeTextController.text;
    final amountText = amoutTextController.text;
    final parsedAmount = double.tryParse(amountText);
    if (purposeText.isEmpty ||
        amountText.isEmpty ||
        categoryID == null ||
        selectedDate == null ||
        selectedCategoryModel == null ||
        parsedAmount == null) {
      return;
    }

    final modal = TransactionModel(
      purpose: purposeText,
      amount: parsedAmount,
      date: selectedDate!,
      type: selectedCategoryType!,
      category: selectedCategoryModel!,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    await TransactionDb.instance.addTransaction(modal);
    navigationSnackBar();
    TransactionDb.instance.refresh();
  }

  navigationSnackBar() {
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
        Expanded(
            child: ValueListenableBuilder(
          valueListenable: selectedCategoryType == CategoryType.income
              ? CategoryDB().incomeCategoryListListener
              : CategoryDB().expenseCategoryListListener,
          builder: (BuildContext context, dynamic value, Widget? child) {
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
              value: categoryID,
              items: (selectedCategoryType == CategoryType.income
                      ? CategoryDB.instance.incomeCategoryListListener
                      : CategoryDB.instance.expenseCategoryListListener)
                  .value
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
                    setState(() {
                      CategoryDB.instance.refreshUI();
                      selectedCategoryModel = e;
                    });
                  },
                );
              }).toList(),
              onChanged: ((selectedValue) {
                // print(selectedValue);
                setState(() {
                  categoryID = selectedValue;
                });
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
                );
                CategoryDB.instance.expenseCategoryListListener
                    .notifyListeners();
                CategoryDB.instance.incomeCategoryListListener
                    .notifyListeners();
              }),
              icon:  Icon(
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
