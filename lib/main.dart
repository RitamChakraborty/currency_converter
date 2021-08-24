import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Converter(),
      child: MaterialApp(
        title: "Currency Converter",
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.cyanAccent,
        ),
        home: Home(),
      ),
    );
  }
}
