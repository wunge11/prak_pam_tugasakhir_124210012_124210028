// main.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:praktikum_disney/DB_Model/login_model.dart';
import 'package:praktikum_disney/login_page.dart';

String boxName = 'login';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LoginModelAdapter());
  await Hive.openBox<LoginModel>(boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
