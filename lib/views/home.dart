import 'package:currency_converter/views/widgets/currency_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            CurrencyWidget(color: Theme.of(context).primaryColor),
            CurrencyWidget(color: Theme.of(context).accentColor),
          ],
        ),
      ),
    );
  }
}
