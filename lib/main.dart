import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/sql/sql_db.dart';
import 'view/pages/home.dart';

void main() {
  initialSql().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: 'Flutter Demo', home: Home());
  }
}
