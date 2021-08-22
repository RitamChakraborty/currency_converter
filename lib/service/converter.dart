import 'package:currency_converter/data/currency_enum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class ConverterState {}

class InitialState extends ConverterState {}

class CurrencyOneChangeState extends ConverterState {}

class CurrencyTwoChangeState extends ConverterState {}

class Converter extends HydratedCubit<ConverterState> {
  Converter() : super(InitialState());

  CurrencyEnum? _currencyOne = CurrencyEnum.USD;
  CurrencyEnum? _currencyTwo = CurrencyEnum.INR;

  CurrencyEnum? get currencyOne => _currencyOne;

  CurrencyEnum? get currencyTwo => _currencyTwo;

  void changeCurrencyOne(CurrencyEnum? currencyEnum) {
    _currencyOne = currencyEnum;
    emit(CurrencyOneChangeState());
  }

  void changeCurrencyTwo(CurrencyEnum? currencyEnum) {
    _currencyTwo = currencyEnum;
    emit(CurrencyTwoChangeState());
  }

  @override
  ConverterState? fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ConverterState state) {
    throw UnimplementedError();
  }
}
