abstract class ConverterState {}

class InitialState extends ConverterState {}

class CurrencyChangedState extends ConverterState {}

class CurrencyAmountChangeState extends ConverterState {}

class ConvertCurrencyState extends ConverterState {}

class FetchingConversionState extends ConverterState {}
