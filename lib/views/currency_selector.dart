import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/service/converter_state.dart';
import 'package:currency_converter/service/inherited_properties.dart';
import 'package:currency_converter/views/widgets/currency_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Converter converter = BlocProvider.of<Converter>(context);
    Color primaryColor = InheritedProperties.of(context).primaryColor;
    Color accentColor = InheritedProperties.of(context).accentColor;
    CurrentCurrency currentCurrency =
        InheritedProperties.of(context).currentCurrency;

    List<Widget> getCurrencies(String? code) {
      return CurrencyEnum.values.map((currency) {
        bool selected = currency == CurrencyUtil.currencyEnumFromCode(code);

        return CurrencyTile(
          currencyName: currency.currency!,
          currencyCode: currency.code!,
          selected: selected,
          onSelected: () {
            converter.changeCurrency(
              currency: currency,
              currentCurrency: currentCurrency,
            );
          },
        );
      }).toList();
    }

    return BlocConsumer<Converter, ConverterState>(
      bloc: converter,
      listener: (context, state) {
        if (state.runtimeType == CurrencyChangedState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            leading: BackButton(
              color: accentColor,
            ),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: CurrencyEnum.values.length,
              itemBuilder: (context, index) =>
                  getCurrencies(converter.getCode(currentCurrency))[index],
            ),
          ),
        );
      },
    );
  }
}
