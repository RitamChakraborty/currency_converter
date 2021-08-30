import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/data/digit_enum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class ConverterState {}

class InitialState extends ConverterState {}

class CurrencyChangedState extends ConverterState {}

class CurrencyAmountChangeState extends ConverterState {}

class Converter extends HydratedCubit<ConverterState> {
  Converter() : super(InitialState());

  CurrencyEnum? _currencyOne = CurrencyEnum.USD;
  CurrencyEnum? _currencyTwo = CurrencyEnum.INR;
  double _currencyOneAmount = 0.0;
  double _currencyTwoAmount = 0.0;

  CurrencyEnum? get currencyOne => _currencyOne;

  CurrencyEnum? get currencyTwo => _currencyTwo;

  double get currencyOneAmount => _currencyOneAmount;

  double get currencyTwoAmount => _currencyTwoAmount;

  String? getCurrency(CurrentCurrency currentCurrency) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        return _currencyOne!.currency;
      case CurrentCurrency.TWO:
        return _currencyTwo!.currency;
    }
  }

  String? getCode(CurrentCurrency currentCurrency) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        return _currencyOne!.code;
      case CurrentCurrency.TWO:
        return _currencyTwo!.code;
    }
  }

  double getAmount(CurrentCurrency currentCurrency) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        return _currencyOneAmount;
      case CurrentCurrency.TWO:
        return _currencyTwoAmount;
    }
  }

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

    emit(CurrencyChangedState());
  }

  void digitPressed(DigitEnum digitEnum, CurrentCurrency currentCurrency) {
    switch (digitEnum) {
      case DigitEnum.ONE:
      case DigitEnum.TWO:
      case DigitEnum.THREE:
      case DigitEnum.FOUR:
      case DigitEnum.FIVE:
      case DigitEnum.SIX:
      case DigitEnum.SEVEN:
      case DigitEnum.EIGHT:
      case DigitEnum.NINE:
      case DigitEnum.ZERO:
        {
          double digit = double.parse(digitEnum.name);
          print(digit);
          break;
        }
      case DigitEnum.POINT:
        {
          break;
        }
      case DigitEnum.BACKSPACE:
        {
          break;
        }
    }

    emit(CurrencyAmountChangeState());
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
