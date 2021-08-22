import 'package:currency_converter/data/currency_enum.dart';
import 'package:currency_converter/data/currency_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("currency_util_test_1", () {
    String? expected = "Indian Rupee";
    String? actual = CurrencyUtil.currencyFromCode("INR");

    expect(actual, expected);
  });

  test("currency_enum_test", () {
    String? expected = "INR";
    String? actual = CurrencyEnum.INR.code;

    expect(actual, expected);
  });

  test("currency_enum_test_2", () {
    String? expected = "Indian Rupee";
    String? actual = CurrencyEnum.INR.currency;

    expect(actual, expected);
  });
}
