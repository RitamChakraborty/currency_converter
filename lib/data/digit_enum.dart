enum DigitEnum {
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX,
  SEVEN,
  EIGHT,
  NINE,
  POINT,
  ZERO,
  BACKSPACE
}

extension DigitEnumExtension on DigitEnum {
  String get name {
    switch (this) {
      case DigitEnum.ONE:
        return "1";
      case DigitEnum.TWO:
        return "2";
      case DigitEnum.THREE:
        return "3";
      case DigitEnum.FOUR:
        return "4";
      case DigitEnum.FIVE:
        return "5";
      case DigitEnum.SIX:
        return "6";
      case DigitEnum.SEVEN:
        return "7";
      case DigitEnum.EIGHT:
        return "8";
      case DigitEnum.NINE:
        return "9";
      case DigitEnum.POINT:
        return ".";
      case DigitEnum.ZERO:
        return "0";
      case DigitEnum.BACKSPACE:
        return "BACKSPACE";
    }
  }
}
