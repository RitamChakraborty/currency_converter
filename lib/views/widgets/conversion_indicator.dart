import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/service/converter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversionIndicator extends StatelessWidget {
  const ConversionIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Converter converter = BlocProvider.of<Converter>(context);

    return BlocBuilder<Converter, ConverterState>(
        bloc: converter,
        builder: (context, converterState) {
          Widget childWidget() {
            if (converterState.runtimeType == FetchingConversionState) {
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              );
            }

            CurrentCurrency? currentCurrency = converter.currentCurrency;
            IconData? iconData;

            if (converterState.runtimeType == ErrorFetchingConversionState) {
              iconData = Icons.error_outline;
            } else if (currentCurrency == null) {
              iconData = Icons.swap_vert;
            } else if (currentCurrency == CurrentCurrency.ONE) {
              iconData = Icons.arrow_downward;
            } else if (currentCurrency == CurrentCurrency.TWO) {
              iconData = Icons.arrow_upward;
            }

            return Icon(
              iconData ?? Icons.price_change,
              color: Theme.of(context).primaryColor,
              size: 50,
            );
          }

          return Container(
            alignment: Alignment.center,
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 10.0,
              ),
            ),
            child: childWidget(),
          );
        });
  }
}
