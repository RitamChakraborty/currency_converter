import 'package:currency_converter/model/ConvertCurrencyRequest.dart';
import 'package:currency_converter/repository/currency_converter_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("", () async {
    CurrencyConverter currencyConverter = CurrencyConverter();

    double? convertedAmount =
        await currencyConverter.convertCurrency(new ConvertCurrencyRequest(
      fromCode: "USD",
      toCode: "INR",
      amount: 1,
    ));

    print(convertedAmount);
  });
}
