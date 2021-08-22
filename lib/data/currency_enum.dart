import 'package:currency_converter/data/currency_util.dart';

enum CurrencyEnum {
  AUD,
  BGN,
  BRL,
  CAD,
  CHF,
  CNY,
  CZK,
  DKK,
  EUR,
  GBP,
  HKD,
  HRK,
  HUF,
  IDR,
  ILS,
  INR,
  ISK,
  JPY,
  KRW,
  MXN,
  MYR,
  NOK,
  NZD,
  PHP,
  PLN,
  RON,
  RUB,
  SEK,
  SGD,
  THB,
  TRY,
  USD,
  ZAR
}

extension CurrencyEnumExtension on CurrencyEnum {
  String? get code => this.toString().split(".")[1];

  String? get currency => CurrencyUtil.currencyFromCode(this.code);
}
