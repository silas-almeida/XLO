import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx2/services/parse_server_services.dart';
import 'package:xlo_mobx2/stores/page_store.dart';

import 'screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ParseServerServices.initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
}

// Future<void> initializeParse() async {
  

  // final category = ParseObject('Categories')
  //   ..set<String>('Title', 'Meias')
  //   ..set<int>('Position', 1);
  // final response = await category.save();
  // print(response.success);

  // final category2 = ParseObject('Categories')
  //   ..set<String>('Title', 'Camisetas')
  //   ..set<int>('Position', 2);
  // final response2 = await category2.save();
  // print(response2.success);

  // final category = ParseObject('Categories')
  //   ..objectId = 'gFXO3c7kWX'
  //   ..set<int>('Position', 3);

  // final response = await category.save();
  // print(response.success);

  // final category = ParseObject('categories')..delete();

  // final response = await ParseObject('Categories').getObject('6TUMjurCbf');
  // if (response.success) {
  //   print(response.result);
  // }

  // final response = await ParseObject('Categories').getAll();
  // if (response.success) {
  //   for (final objetct in response.results) {
  //     print(objetct);
  //   }
  // }

  // final query = QueryBuilder(ParseObject('Categories'));
  // query.whereEqualTo('Position', 2);

  // final response = await query.query();
  // if (response.success) {
  //   print(response.result);
  // }

  // final query = QueryBuilder(ParseObject('Categories'));
  // query.whereContains('Title', 'Blusa');
  // query.whereEqualTo('Position', 2);

  // final response = await query.query();
  // if (response.success) {
  //   print(response.result);
  // }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseScreen(),
    );
  }
}