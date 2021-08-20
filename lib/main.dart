import 'package:currency_converter/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Currency Converter",
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.cyanAccent,
      ),
      home: Home(),
    );
  }
}
