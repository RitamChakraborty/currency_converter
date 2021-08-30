import 'package:currency_converter/data/digit_enum.dart';
import 'package:flutter/material.dart';

class DigitUtil {
  static Widget getDigitWidget(
      {required DigitEnum digitEnum, required Color color}) {
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
      case DigitEnum.POINT:
      case DigitEnum.ZERO:
        {
          return Text(
            digitEnum.name,
            style: TextStyle(
              fontSize: 24,
              color: color,
            ),
          );
        }
      case DigitEnum.BACKSPACE:
        {
          return Icon(
            Icons.backspace,
            size: 24,
            color: color,
          );
        }
    }
  }
}
