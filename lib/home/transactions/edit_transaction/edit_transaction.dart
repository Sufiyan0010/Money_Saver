import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../db_functions/category_db/category_db.dart';
import '../../../db_functions/transactions_db/transaction_db.dart';
import '../../../models/category_model/category_model.dart';
import '../../../models/transactions_model/transaction_model.dart';
import '../../../styles/styles.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction({
    Key? key,
    required this.obj,
    this.id,
  }) : super(key: key);

  final String? id;
  final TransactionModel obj;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  TextEditingController amoutTextController = TextEditingController();
  TextEditingController purposeTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;
  String? categoryID;
  int _value = 0;

  @override
  void initState() {
    super.initState();
    selectedCategoryType = CategoryType.income;
    _value = widget.obj.type.index;
    categoryID = widget.obj.category.id;
    selectedCategoryModel = widget.obj.category;
    selectedCategoryType = widget.obj.type;
    selectedDate = widget.obj.date;
    amoutTextController =
        TextEditingController(text: widget.obj.amount.toString());
    purposeTextController = TextEditingController(text: widget.obj.purpose);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: greenShade,
        centerTitle: true,
        title: Text(
          'Update Transaction',
          style: TextStyle(
              fontFamily: 'hubballi',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: whiteShade),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: const Text(
                      'Income',
                    ),
                    backgroundColor: whiteShade,
                    selectedColor: const Color.fromARGB(255, 30, 217, 123),
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
                    backgroundColor: whiteShade,
                    selectedColor: const Color.fromARGB(255, 255, 17, 17),
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
              DropdownButtonFormField<String>(
                iconEnabledColor: greenShade,
                iconSize: 20,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenShade, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greenShade, width: 2),
                    )),
                value: categoryID,
                hint: Text(
                  'Select Category',
                  style: TextStyle(
                      color: blueShade,
                      fontFamily: 'hubballi',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                items: (selectedCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(
                      e.name,
                      style: TextStyle(
                          color: blueShade,
                          fontFamily: 'hubballi',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    categoryID = selectedValue;
                  });
                },
              ),
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
                    fontSize: 15,
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
                    if (formKey.currentState!.validate()) {
                      updateTransaction();
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: whiteShade,
                  ),
                  label: Text(
                    'Update',
                    style: TextStyle(
                        color: whiteShade,
                        fontFamily: 'hubballi',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future updateTransaction() async {
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
      id: widget.obj.id,
    );
    await TransactionDb.instance.editTransaction(modal);
    navigationSnackBar();
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();

  }

  navigationSnackBar() {
    Navigator.of(context).pop();
    AnimatedSnackBar.material(
      'Transaction Updated Successfully',
      borderRadius: BorderRadius.circular(20),
      
      // mobileSnackBarPosition: MobileSnackBarPosition.top,
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
}
