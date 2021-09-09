import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/service/inherited_properties.dart';
import 'package:currency_converter/views/amount.dart';
import 'package:currency_converter/views/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Converter converter = BlocProvider.of<Converter>(context);
    Color primaryColor = InheritedProperties.of(context).primaryColor;
    Color accentColor = InheritedProperties.of(context).accentColor;
    CurrentCurrency currentCurrency =
        InheritedProperties.of(context).currentCurrency;

    Widget currencyText({required String? currency}) => TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => InheritedProperties(
                  primaryColor: primaryColor,
                  accentColor: accentColor,
                  currentCurrency: currentCurrency,
                  child: CurrencySelector(),
                ),
              ),
            );
          },
          child: Text(
            currency ?? "NULL",
            style: TextStyle(
              color: accentColor,
            ),
          ),
        );

    Widget amountText({required String amount}) => TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => InheritedProperties(
                  primaryColor: primaryColor,
                  accentColor: accentColor,
                  currentCurrency: currentCurrency,
                  child: Amount(),
                ),
              ),
            );
          },
          child: Text(
            amount,
            style: TextStyle(
              color: accentColor,
            ),
          ),
        );

    Text currencyCodeText({required String? code}) => Text(
          code ?? "NULL",
          style: TextStyle(
            color: accentColor,
          ),
        );

    return BlocConsumer<Converter, ConverterState>(
      bloc: converter,
      listener: (context, state) {},
      builder: (context, state) {
        String? currency = converter.getCurrency(currentCurrency);
        String? code = converter.getCode(currentCurrency);
        String amount = converter.getSanitizeAmount(currentCurrency);

        return Expanded(
          child: Container(
            color: primaryColor,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currencyText(currency: currency),
                amountText(amount: amount),
                currencyCodeText(code: code),
              ],
            ),
          ),
        );
      },
    );
  }
}
