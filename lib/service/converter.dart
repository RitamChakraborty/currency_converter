import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/data/digit_enum.dart';
import 'package:currency_converter/model/convert_currency_request.dart';
import 'package:currency_converter/repository/currency_converter_repository.dart';
import 'package:currency_converter/service/converter_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class Converter extends HydratedCubit<ConverterState> {
  Converter() : super(InitialState());

  CurrencyEnum? _currencyOne = CurrencyEnum.INR;
  CurrencyEnum? _currencyTwo = CurrencyEnum.INR;
  String _currencyOneAmount = "";
  String _currencyTwoAmount = "";
  CurrentCurrency? _currentCurrency;
  final CurrencyConverterRepository _currencyConverterRepository =
      CurrencyConverterRepository();

  CurrencyEnum? get currencyOne => _currencyOne;

  CurrencyEnum? get currencyTwo => _currencyTwo;

  String get currencyOneAmount => _currencyOneAmount;

  String get currencyTwoAmount => _currencyTwoAmount;

  CurrentCurrency? get currentCurrency => _currentCurrency;

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
        {
          _currencyOneAmount = currencyAmount;

          if (_currencyOneAmount == "0") {
            _currencyTwoAmount = "0";
          }

          break;
        }
      case CurrentCurrency.TWO:
        {
          _currencyTwoAmount = currencyAmount;

          if (_currencyTwoAmount == "0") {
            _currencyOneAmount = "0";
          }

          break;
        }
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

    return amount;
  }

  String getSanitizedAmount(CurrentCurrency currentCurrency) {
    switch (currentCurrency) {
      case CurrentCurrency.ONE:
        _currencyOneAmount = _sanitizeAmount(_currencyOneAmount);
        return _currencyOneAmount;
      case CurrentCurrency.TWO:
        _currencyTwoAmount = _sanitizeAmount(_currencyTwoAmount);
        return _currencyTwoAmount;
    }
  }

  String _sanitizeAmount(String amount) {
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
    convertCurrency(currentCurrency);
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
          currencyAmount = currencyAmount == "0" ? "" : currencyAmount;

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
    getSanitizedAmount(currentCurrency);
    _currentCurrency = currentCurrency;
    String? amountString;
    String? fromCode;
    String? toCode;

    if (currentCurrency == CurrentCurrency.ONE) {
      amountString = currencyOneAmount;
      fromCode = _currencyOne?.code;
      toCode = _currencyTwo?.code;
    } else if (currentCurrency == CurrentCurrency.TWO) {
      amountString = currencyTwoAmount;
      fromCode = _currencyTwo?.code;
      toCode = _currencyOne?.code;
    }

    if (amountString != null && fromCode != null && toCode != null) {
      try {
        double amount = double.parse(amountString);

        if (amount == 0) {
          _setAmount(
              currentCurrency == CurrentCurrency.ONE
                  ? CurrentCurrency.TWO
                  : CurrentCurrency.ONE,
              "0");

          return emit(ConvertCurrencyState());
        }

        ConvertCurrencyRequest convertCurrencyRequest = ConvertCurrencyRequest(
          fromCode: fromCode,
          toCode: toCode,
          amount: amount,
        );

        emit(FetchingConversionState());

        _currencyConverterRepository
            .convertCurrency(convertCurrencyRequest)
            .then((value) {
          if (value != null) {
            _setAmount(
                currentCurrency == CurrentCurrency.ONE
                    ? CurrentCurrency.TWO
                    : CurrentCurrency.ONE,
                value.toStringAsFixed(2));
          }
        }).whenComplete(() => emit(ConvertCurrencyState()));
      } catch (e) {
        print("Converter.convertCurrency() error : $e");
      }
    }
  }

  @override
  ConverterState? fromJson(Map<String, dynamic> json) {
    String? currencyOneCode = json['currency_one'];
    String? currencyTwoCode = json['currency_two'];
    _currencyOne = CurrencyUtil.currencyEnumFromCode(currencyOneCode);
    _currencyTwo = CurrencyUtil.currencyEnumFromCode(currencyTwoCode);
    _currencyOneAmount = json['currency_one_amount'] ?? "1";
    _currencyTwoAmount = json['currency_two_amount'] ?? "1";
    // _currentCurrency = json['current_currency'];

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
      // 'current_currency': _currentCurrency,
    };
  }
}
