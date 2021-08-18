import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/currency.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  final List<Currency> _currencies = [
    Currency(
      name: "Canadian Dollar",
      symbol: "CAD",
    ),
    Currency(
      name: "Hong Kong Dollar",
      symbol: "HKD",
    ),
    Currency(
      name: "Icelandic Krona",
      symbol: "ISK",
    ),
    Currency(
      name: "Philippines Peso",
      symbol: "PHP",
    ),
    Currency(
      name: "Danish Krona",
      symbol: "DKK",
    ),
    Currency(
      name: "Hungerian Forint",
      symbol: "HUF",
    ),
    Currency(
      name: "Czech Koruna",
      symbol: "CZK",
    ),
    Currency(
      name: "Pound Sterling",
      symbol: "GBP",
    ),
    Currency(
      name: "Romanian Leu",
      symbol: "RON",
    ),
    Currency(
      name: "Swedish Krona",
      symbol: "SEK",
    ),
    Currency(
      name: "Indonesian Rupiah",
      symbol: "IDR",
    ),
    Currency(
      name: "Indian Rupee",
      symbol: "INR",
    ),
    Currency(
      name: "Brazilian Real",
      symbol: "BRL",
    ),
    Currency(
      name: "Russian Rubel",
      symbol: "RUB",
    ),
    Currency(
      name: "Kroatian Kuna",
      symbol: "HRK",
    ),
    Currency(
      name: "Japanese Yen",
      symbol: "JPY",
    ),
    Currency(
      name: "Thai Baht",
      symbol: "THB",
    ),
    Currency(
      name: "Swiss Franc",
      symbol: "CHF",
    ),
    Currency(
      name: "Euro",
      symbol: "EUR",
    ),
    Currency(
      name: "Malaysian Ringgit",
      symbol: "MYR",
    ),
    Currency(
      name: "Bulgerian Lev",
      symbol: "BGN",
    ),
    Currency(
      name: "Turkish Lira",
      symbol: "TRY",
    ),
    Currency(
      name: "Chinese Yuan",
      symbol: "CNY",
    ),
    Currency(
      name: "Norwegian Krona",
      symbol: "NOK",
    ),
    Currency(
      name: "New Zeland Dollar",
      symbol: "NZD",
    ),
    Currency(
      name: "South African Rand",
      symbol: "ZAR",
    ),
    Currency(
      name: "US Dollar",
      symbol: "USD",
    ),
    Currency(
      name: "Mexican Peso",
      symbol: "MXN",
    ),
    Currency(
      name: "Singapore Dollar",
      symbol: "SGD",
    ),
    Currency(
      name: "Australian Dollar",
      symbol: "AUD",
    ),
    Currency(
      name: "Israeli New Shekel",
      symbol: "ILS",
    ),
    Currency(
      name: "South Korean Won",
      symbol: "KRW",
    ),
    Currency(
      name: "Poland Zloty",
      symbol: "PLN",
    ),
  ];
}

class _BodyState extends State<Body> {
  TextEditingController? _textEditingController;
  final _minPadding = EdgeInsets.all(8.0);
  final _maxPadding = EdgeInsets.all(17.0);
  late Currency _enteredCurrency;
  late Currency _convertedCurrency;
  var _formKey = GlobalKey<FormState>();
  double? _finalValue;
  late String _resultString;
  String _api = "https://api.exchangeratesapi.io/latest?base=";
  double? _conversionRate;

  Future<double?> getCurrencyValues(
      String base, String converted, double amount) async {
    var data = await http.get(Uri.parse(_api + base));
    var jsonData = json.decode(data.body);
    _conversionRate = jsonData['rates'][converted];

    setState(() {
      _resultString = _conversionRate == 0.0
          ? "Loading..."
          : (amount * _conversionRate!).toString();
    });

    return _conversionRate;
  }

  void _handleConvertButtonPressed() {
    double amount;
    setState(() {
      if (_formKey.currentState!.validate()) {
        amount = double.parse(_textEditingController!.text);

        getCurrencyValues(
            _enteredCurrency.symbol, _convertedCurrency.symbol, amount);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget._currencies
        .sort((Currency a, Currency b) => a.name.compareTo(b.name));
    _textEditingController = TextEditingController();
    _enteredCurrency = widget._currencies[0];
    _convertedCurrency = widget._currencies[1];
    _resultString = "";
  }

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              textFormField(
                  labelText: "Amount",
                  hintText: "Enter amount to be converted",
                  controller: _textEditingController,
                  formKey: _formKey,
                  context: context),
              SizedBox(
                height: 12.0,
              ),
              Divider(),
              SizedBox(
                height: 12.0,
              ),
              customRow(
                  text: "Select entered currency",
                  list: widget._currencies,
                  value: _enteredCurrency.name,
                  key: 0,
                  context: context),
              SizedBox(
                height: 16.0,
              ),
              customRow(
                  text: "Select currecy to be converted with",
                  list: widget._currencies,
                  value: _convertedCurrency.name,
                  key: 1,
                  context: context),
              SizedBox(
                height: 32,
              ),
              convertButton(context: context),
              SizedBox(
                height: 32,
              ),
              resultBox(context: context),
            ],
          )
        ],
      );

  Widget textFormField(
      {required String labelText,
      required String hintText,
      required TextEditingController? controller,
      required Key formKey,
      required BuildContext context}) {
    final labelStyle =
        TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 16.0);

    final hintStyle =
        TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 16.0);

    final borderSide = BorderSide(
        color: Theme.of(context).primaryColorDark,
        width: 4.0,
        style: BorderStyle.solid);

    final outlineInputBorder = OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: labelStyle,
            hintText: hintText,
            hintStyle: hintStyle,
            border: outlineInputBorder),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter some amount";
          }

          return null;
        },
        controller: controller,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Decoration boxDecoration({required BuildContext context}) => BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 2.0,
          style: BorderStyle.solid));

  Widget customRow({
    required String text,
    required List<Currency> list,
    required String value,
    required int key,
    required BuildContext context,
  }) {
    final textWidget = Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).primaryColorDark,
        fontSize: 18.0,
      ),
    );

    final textContainer = Expanded(
        child: Container(
            padding: _minPadding,
            height: 60,
            decoration: boxDecoration(context: context),
            child: Center(
              child: textWidget,
            )));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        textContainer,
        SizedBox(
          width: 8.0,
        ),
        dropdownMenuButton(
            list: list, value: value, key: key, context: context),
      ],
    );
  }

  Widget dropdownMenuButton(
          {required List<Currency> list,
          required String value,
          required int key,
          required BuildContext context}) =>
      Container(
        decoration: boxDecoration(context: context),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButton<String>(
            items: list
                .map((Currency dropdownItem) => DropdownMenuItem<String>(
                      value: dropdownItem.name,
                      child: Text(
                        dropdownItem.name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: (String? dropdownItem) {
              setState(() {
                if (key == 0) {
                  _enteredCurrency = findItem(dropdownItem);
                } else if (key == 1) {
                  _convertedCurrency = findItem(dropdownItem);
                }
              });
            }),
      );

  Currency findItem(String? item) {
    for (Currency i in widget._currencies) {
      if (i.name == item) {
        return i;
      }
    }
    return widget._currencies[0];
  }

  Widget convertButton({required BuildContext context}) => MaterialButton(
        padding: _maxPadding,
        elevation: 5.0,
        color: Theme.of(context).primaryColorDark,
        splashColor: Theme.of(context).splashColor,
        textColor: Colors.white,
        shape: StadiumBorder(
            side: BorderSide(color: Theme.of(context).accentColor)),
        child: Text(
          "Convert",
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: _handleConvertButtonPressed,
      );

  Widget resultBox({required BuildContext context}) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration(context: context),
        padding: _maxPadding,
        child: Text(
          _resultString,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24.0, color: Theme.of(context).primaryColorDark),
        ),
      );
}
