import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:currency_converter/data/current_currency.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class ConverterState {}

class InitialState extends ConverterState {}

class CurrencyChangedState extends ConverterState {}

class Converter extends HydratedCubit<ConverterState> {
  Converter() : super(InitialState());

  CurrencyEnum? _currencyOne = CurrencyEnum.USD;
  CurrencyEnum? _currencyTwo = CurrencyEnum.INR;

  CurrencyEnum? get currencyOne => _currencyOne;

  CurrencyEnum? get currencyTwo => _currencyTwo;

  void changeCurrency({
    required CurrencyEnum? currency,
    required CurrentCurrency currentCurrency,
  }) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        {
          _currencyOne = currency;
          break;
        }
      case CurrentCurrency.TWO:
        {
          _currencyTwo = currency;
          break;
        }
    }

    print(currency);
    emit(CurrencyChangedState());
  }

  @override
  ConverterState? fromJson(Map<String, dynamic> json) {
    String? currencyOneCode = json['currency_one'];
    String? currencyTwoCode = json['currency_two'];
    _currencyOne = CurrencyUtil.currencyEnumFromCode(currencyOneCode);
    _currencyTwo = CurrencyUtil.currencyEnumFromCode(currencyTwoCode);

    return InitialState();
  }

  @override
  Map<String, dynamic>? toJson(ConverterState state) {
    if (_currencyOne != null && _currencyTwo != null) {
      return {
        'currency_one': _currencyOne!.code,
        'currency_two': _currencyTwo!.code,
      };
    }

    return {
      'currency_one': CurrencyEnum.USD.code,
      'currency_two': CurrencyEnum.INR.code,
    };
  }
}
