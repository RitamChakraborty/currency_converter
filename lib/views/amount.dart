import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/data/digit_enum.dart';
import 'package:currency_converter/data/digit_util.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/service/converter_state.dart';
import 'package:currency_converter/service/inherited_properties.dart';
import 'package:currency_converter/views/widgets/blinking_cursor.dart';
import 'package:currency_converter/views/widgets/digit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Amount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Converter converter = BlocProvider.of<Converter>(context);
    Color primaryColor = InheritedProperties.of(context).primaryColor;
    Color accentColor = InheritedProperties.of(context).accentColor;
    CurrentCurrency currentCurrency =
        InheritedProperties.of(context).currentCurrency;

    final List<Widget> digitButtons = DigitEnum.values
        .map((digitEnum) => DigitButton(
              text: digitEnum.name,
              child: DigitUtil.getDigitWidget(
                  digitEnum: digitEnum, color: primaryColor),
              onPressed: () {
                converter.digitPressed(digitEnum, currentCurrency);
              },
            ))
        .toList();

    Widget amountText(String amount) {
      return Text(
        amount,
        style: TextStyle(
          color: accentColor,
          fontSize: 64.0,
        ),
      );
    }

    Widget backButton() {
      return IconButton(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 36.0,
          color: accentColor,
        ),
        onPressed: () {
          converter.convertCurrency(currentCurrency);
        },
      );
    }

    return BlocConsumer<Converter, ConverterState>(
      bloc: converter,
      listener: (context, state) {
        if (state.runtimeType == ConvertCurrencyState ||
            state.runtimeType == FetchingConversionState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      amountText(
                        converter.getAmount(currentCurrency),
                      ),
                      BlinkingCursor(),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: digitButtons.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                      mainAxisExtent: MediaQuery.of(context).size.height / 9,
                    ),
                    itemBuilder: (context, index) {
                      return digitButtons[index];
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: backButton(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
