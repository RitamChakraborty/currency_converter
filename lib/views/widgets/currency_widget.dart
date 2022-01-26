import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/service/converter_state.dart';
import 'package:currency_converter/service/inherited_properties.dart';
import 'package:currency_converter/views/amount.dart';
import 'package:currency_converter/views/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, animationTime, child) =>
                        SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                pageBuilder: (context, animation, animationTime) =>
                    InheritedProperties(
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
              fontSize: 32.0,
            ),
          ),
        );

    Widget amountText({required String amount, String? code}) => TextButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, animationTime, child) =>
                        SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                pageBuilder: (context, animation, animationTime) =>
                    InheritedProperties(
                  primaryColor: primaryColor,
                  accentColor: accentColor,
                  currentCurrency: currentCurrency,
                  child: Amount(),
                ),
              ),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: amount,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 64.0,
                  ),
                ),
                TextSpan(
                  text: " " +
                      NumberFormat.simpleCurrency(name: code).currencySymbol,
                  style: TextStyle(
                    color: accentColor.withOpacity(0.5),
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
        );

    Text currencyCodeText({required String? code}) => Text(
          code ?? "NULL",
          style: TextStyle(
            color: accentColor,
            fontSize: 24.0,
          ),
        );

    return BlocConsumer<Converter, ConverterState>(
      bloc: converter,
      listener: (context, state) {},
      builder: (context, state) {
        String? currency = converter.getCurrency(currentCurrency);
        String? code = converter.getCode(currentCurrency);
        String amount = converter.getAmount(currentCurrency);

        if (state.runtimeType != CurrencyAmountChangeState) {
          amount = converter.getSanitizedAmount(currentCurrency);
        }

        List<Widget> children = [
          currencyText(currency: currency),
          amountText(amount: amount, code: code),
          currencyCodeText(code: code),
          SizedBox(height: 5),
        ];

        if (currentCurrency == CurrentCurrency.TWO) {
          children = children.reversed.toList();
        }

        return Expanded(
          child: Container(
            color: primaryColor,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
