import 'package:currency_converter/model/convert_currency_request.dart';
import 'package:currency_converter/repository/currency_converter_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("", () async {
    CurrencyConverterRepository currencyConverter =
        CurrencyConverterRepository();

    double? convertedAmount =
        await currencyConverter.convertCurrency(new ConvertCurrencyRequest(
      fromCode: "USD",
      toCode: "INR",
      amount: 1,
    ));

    print(convertedAmount);
  });
}
