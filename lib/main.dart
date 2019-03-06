import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Currency Converter"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Currency Converter"),
        ),
      ));
}
