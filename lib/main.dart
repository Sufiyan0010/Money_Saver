import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_saver/controller/category_db/category_db.dart';
import 'package:money_saver/controller/category_db/category_type_provider.dart';
import 'package:money_saver/controller/transactions_db/add_transaction_provider.dart';
import 'package:money_saver/controller/transactions_db/transaction_db.dart';

import 'package:money_saver/models/category_model/category_model.dart';
import 'package:money_saver/models/transactions_model/transaction_model.dart';

import 'package:money_saver/view/splash/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TransactionProvider())),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: ((context) => AddTransactionProvider())),
              ChangeNotifierProvider(create: ((context) => CategoryTypeProvider())),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: 'MONEY SAVER',
      ),
    );
  }
}
