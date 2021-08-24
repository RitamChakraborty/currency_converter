import 'package:flutter/material.dart';

class CurrencyTile extends StatelessWidget {
  final String _currencyName;
  final String _currencyCode;
  final Color _textColor;
  final VoidCallback _onSelected;

  const CurrencyTile({
    required String currencyName,
    required String currencyCode,
    required Color textColor,
    required VoidCallback onSelected,
    Key? key,
  })  : this._currencyName = currencyName,
        this._currencyCode = currencyCode,
        this._textColor = textColor,
        this._onSelected = onSelected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget title = Text(
      _currencyName,
      style: TextStyle(
        color: _textColor,
      ),
    );
    final Widget trailing = Text(
      _currencyCode,
      style: TextStyle(
        color: _textColor,
      ),
    );

    return ListTile(
      title: title,
      trailing: trailing,
      onTap: _onSelected,
    );
  }
}
