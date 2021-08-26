import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/views/widgets/currency_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelector extends StatelessWidget {
  final Color _color;
  final Color _textColor;
  final CurrentCurrency _currentCurrency;

  const CurrencySelector({
    required Color color,
    required Color textColor,
    required CurrentCurrency currentCurrency,
    Key? key,
  })  : this._color = color,
        this._textColor = textColor,
        this._currentCurrency = currentCurrency,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Converter converter = BlocProvider.of<Converter>(context);

    List<Widget> getCurrencies(String? code) {
      return CurrencyEnum.values.map((currency) {
        bool selected = currency == CurrencyUtil.currencyEnumFromCode(code);

        return CurrencyTile(
          currencyName: currency.currency!,
          currencyCode: currency.code!,
          textColor: _textColor,
          selected: selected,
          onSelected: () {
            converter.changeCurrency(
              currency: currency,
              currentCurrency: _currentCurrency,
            );
          },
        );
      }).toList();
    }

    return BlocBuilder<Converter, ConverterState>(
      bloc: converter,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _color,
          appBar: AppBar(
            backgroundColor: _color,
            elevation: 0,
            leading: BackButton(
              color: _textColor,
            ),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: CurrencyEnum.values.length,
              itemBuilder: (context, index) =>
                  getCurrencies(converter.getCode(_currentCurrency))[index],
            ),
          ),
        );
      },
    );
  }
}
