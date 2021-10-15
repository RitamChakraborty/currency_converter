import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/inherited_properties.dart';
import 'package:currency_converter/views/widgets/conversion_indicator.dart';
import 'package:currency_converter/views/widgets/currency_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                InheritedProperties(
                  primaryColor: Theme.of(context).primaryColor,
                  accentColor: Theme.of(context).accentColor,
                  currentCurrency: CurrentCurrency.ONE,
                  child: CurrencyWidget(),
                ),
                InheritedProperties(
                  primaryColor: Theme.of(context).accentColor,
                  accentColor: Theme.of(context).primaryColor,
                  currentCurrency: CurrentCurrency.TWO,
                  child: CurrencyWidget(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: ConversionIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
