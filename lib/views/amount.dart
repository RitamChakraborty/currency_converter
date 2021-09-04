import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/data/digit_enum.dart';
import 'package:currency_converter/data/digit_util.dart';
import 'package:currency_converter/service/converter.dart';
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
      );
    }

    return BlocBuilder<Converter, ConverterState>(
        bloc: converter,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              leading: BackButton(),
            ),
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
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 3,
                        mainAxisExtent: MediaQuery.of(context).size.height / 9,
                      ),
                      itemBuilder: (context, index) {
                        return digitButtons[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
