import 'package:currency_converter/service/inherited_properties.dart';
import 'package:flutter/material.dart';

class CurrencyTile extends StatelessWidget {
  final String _currencyName;
  final String _currencyCode;
  final bool _selected;
  final VoidCallback _onSelected;

  const CurrencyTile({
    required String currencyName,
    required String currencyCode,
    required bool selected,
    required VoidCallback onSelected,
    Key? key,
  })  : this._currencyName = currencyName,
        this._currencyCode = currencyCode,
        this._selected = selected,
        this._onSelected = onSelected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = InheritedProperties.of(context).accentColor;

    final Widget title = Text(
      _currencyName,
      style: TextStyle(
        color: textColor,
      ),
    );
    final Widget trailing = Text(
      _currencyCode,
      style: TextStyle(
        color: textColor,
      ),
    );

    return ListTile(
      title: title,
      trailing: trailing,
      tileColor: _selected ? Colors.black12 : Colors.transparent,
      onTap: _onSelected,
    );
  }
}
