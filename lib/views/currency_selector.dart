import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/views/widgets/currency_tile.dart';
import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final Color _color;
  final Color _textColor;

  const CurrencySelector({
    required Color color,
    required Color textColor,
    Key? key,
  })  : this._color = color,
        this._textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> currencies = CurrencyEnum.values.map((currency) {
      return CurrencyTile(
        currencyName: currency.currency!,
        currencyCode: currency.code!,
        textColor: _textColor,
        onSelected: () {
          print(currency);
        },
      );
    }).toList();

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
        itemBuilder: (context, index) => currencies[index],
      )),
    );
  }
}
