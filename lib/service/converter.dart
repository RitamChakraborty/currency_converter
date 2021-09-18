import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/data/digit_enum.dart';
import 'package:currency_converter/service/converter_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class Converter extends HydratedCubit<ConverterState> {
  Converter() : super(InitialState());

  CurrencyEnum? _currencyOne = CurrencyEnum.INR;
  CurrencyEnum? _currencyTwo = CurrencyEnum.INR;
  String _currencyOneAmount = "";
  String _currencyTwoAmount = "";

  CurrencyEnum? get currencyOne => _currencyOne;

  CurrencyEnum? get currencyTwo => _currencyTwo;

  String get currencyOneAmount => _currencyOneAmount;

  String get currencyTwoAmount => _currencyTwoAmount;

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

  void _setAmount(CurrentCurrency currentCurrency, String currencyAmount) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        _currencyOneAmount = currencyAmount == "" ? "0" : currencyAmount;
        _currencyTwoAmount = "--";
        break;
      case CurrentCurrency.TWO:
        _currencyTwoAmount = currencyAmount == "" ? "0" : currencyAmount;
        _currencyOneAmount = "--";
        break;
    }
  }

  String getAmount(CurrentCurrency currentCurrency) {
    String amount = "";

    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        amount = _currencyOneAmount;
        break;
      case CurrentCurrency.TWO:
        amount = _currencyTwoAmount;
        break;
    }

    return amount == "--" ? "" : amount;
  }

  String getSanitizedAmount(CurrentCurrency currentCurrency) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        _currencyOneAmount = sanitizeAmount(_currencyOneAmount);
        return _currencyOneAmount;
      case CurrentCurrency.TWO:
        _currencyTwoAmount = sanitizeAmount(_currencyTwoAmount);
        return _currencyTwoAmount;
    }
  }

  String sanitizeAmount(String amount) {
    if (amount.endsWith(".")) {
      amount = amount.substring(0, amount.length - 1);
    } else if (amount == "") {
      amount = "0";
    }

    return amount;
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
    String currencyAmount = getAmount(currentCurrency);

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
          if (currencyAmount.contains(".")) {
            if (currencyAmount.split(".")[1].length < 2) {
              currencyAmount += digitEnum.name;
            }
          } else {
            currencyAmount += digitEnum.name;
          }

          break;
        }
      case DigitEnum.POINT:
        {
          currencyAmount += ".";
          break;
        }
      case DigitEnum.BACKSPACE:
        {
          if (currencyAmount.length > 0) {
            currencyAmount =
                currencyAmount.substring(0, currencyAmount.length - 1);
          }

          break;
        }
    }

    _setAmount(currentCurrency, currencyAmount);
    emit(CurrencyAmountChangeState());
  }

  void convertCurrency(CurrentCurrency currentCurrency) {
    print(currencyOneAmount);
    print(currencyTwoAmount);

    emit(ConvertCurrencyState());
  }

  @override
  ConverterState? fromJson(Map<String, dynamic> json) {
    String? currencyOneCode = json['currency_one'];
    String? currencyTwoCode = json['currency_two'];
    _currencyOne = CurrencyUtil.currencyEnumFromCode(currencyOneCode);
    _currencyTwo = CurrencyUtil.currencyEnumFromCode(currencyTwoCode);
    _currencyOneAmount = json['currency_one_amount'] ?? "1";
    _currencyTwoAmount = json['currency_two_amount'] ?? "1";

    return InitialState();
  }

  @override
  Map<String, dynamic>? toJson(ConverterState state) {
    return {
      'currency_one':
          _currencyOne == null ? CurrencyEnum.USD.code : _currencyOne!.code,
      'currency_two':
          _currencyTwo == null ? CurrencyEnum.INR.code : _currencyTwo!.code,
      'currency_one_amount': _currencyOneAmount,
      'currency_two_amount': _currencyTwoAmount,
    };
  }
}
