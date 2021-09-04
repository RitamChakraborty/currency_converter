import 'package:currency_converter/data/current_currency.dart';
import 'package:flutter/material.dart';

class InheritedProperties extends InheritedWidget {
  const InheritedProperties({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.currentCurrency,
    required Widget child,
  }) : super(key: key, child: child);

  final Color primaryColor;
  final Color accentColor;
  final CurrentCurrency currentCurrency;

  static InheritedProperties of(BuildContext context) {
    final InheritedProperties? result =
        context.dependOnInheritedWidgetOfExactType<InheritedProperties>();
    assert(result != null, 'No InheritedProperties found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedProperties old) {
    return true;
  }
}
