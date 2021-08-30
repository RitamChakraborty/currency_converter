import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/data/digit_enum.dart';
import 'package:currency_converter/data/digit_util.dart';
import 'package:currency_converter/views/widgets/blinking_cursor.dart';
import 'package:currency_converter/views/widgets/digit_button.dart';
import 'package:flutter/material.dart';

class Amount extends StatelessWidget {
  Amount({
    required Color color,
    required Color textColor,
    required CurrentCurrency currentCurrency,
    Key? key,
  })  : this._color = color,
        this._textColor = textColor,
        this._currentCurrency = currentCurrency,
        super(key: key);

  final Color _color;
  final Color _textColor;
  final CurrentCurrency _currentCurrency;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final backButton = Align(
      alignment: Alignment.center,
      child: FloatingActionButton(
        backgroundColor: _textColor,
        child: Icon(
          Icons.backspace,
          size: 24,
          color: _color,
        ),
        onPressed: () {},
      ),
    );

    final List<Widget> digitButtons = DigitEnum.values
        .map((digitEnum) => DigitButton(
              text: digitEnum.name,
              color: _textColor,
              textColor: _color,
              child:
                  DigitUtil.getDigitWidget(digitEnum: digitEnum, color: _color),
              onPressed: () {},
            ))
        .toList();

    return Scaffold(
      backgroundColor: _color,
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
                  Text(""),
                  BlinkingCursor(
                    cursorColor: _textColor,
                  ),
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
          ],
        ),
      ),
    );
  }
}
