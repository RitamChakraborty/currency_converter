import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  final List<String> _currencies = ["Rupees", "Dollar", "Pound", "Euro"];
}

class _BodyState extends State<Body> {
  TextEditingController _textEditingController;
  final _minPadding = EdgeInsets.all(8.0);
  final _maxPadding = EdgeInsets.all(17.0);
  String _enteredCurrency;
  String _convertedCurrency;
  var _formKey = GlobalKey<FormState>();
  double _finalValue;
  String _resultString;

  void _handleConvertButtonPressed() {
    double amount;
    setState(() {
      if (_formKey.currentState.validate()) {
        amount = double.parse(_textEditingController.text);

        if (_enteredCurrency == widget._currencies[0] &&
            _convertedCurrency == widget._currencies[0]) {
          _finalValue = amount;
        } else if (_enteredCurrency == widget._currencies[0] &&
            _convertedCurrency == widget._currencies[1]) {
          _finalValue = amount * 0.014;
        } else if (_enteredCurrency == widget._currencies[0] &&
            _convertedCurrency == widget._currencies[2]) {
          _finalValue = amount * 0.011;
        } else if (_enteredCurrency == widget._currencies[0] &&
            _convertedCurrency == widget._currencies[3]) {
          _finalValue = amount * 0.013;
        } else if (_enteredCurrency == widget._currencies[1] &&
            _convertedCurrency == widget._currencies[1]) {
          _finalValue = amount;
        } else if (_enteredCurrency == widget._currencies[1] &&
            _convertedCurrency == widget._currencies[0]) {
          _finalValue = amount * 70.29;
        } else if (_enteredCurrency == widget._currencies[1] &&
            _convertedCurrency == widget._currencies[2]) {
          _finalValue = amount * 0.76;
        } else if (_enteredCurrency == widget._currencies[1] &&
            _convertedCurrency == widget._currencies[3]) {
          _finalValue = amount * 0.88;
        } else if (_enteredCurrency == widget._currencies[2] &&
            _convertedCurrency == widget._currencies[2]) {
          _finalValue = amount;
        } else if (_enteredCurrency == widget._currencies[2] &&
            _convertedCurrency == widget._currencies[0]) {
          _finalValue = amount * 92.38;
        } else if (_enteredCurrency == widget._currencies[2] &&
            _convertedCurrency == widget._currencies[1]) {
          _finalValue = amount * 1.31;
        } else if (_enteredCurrency == widget._currencies[2] &&
            _convertedCurrency == widget._currencies[3]) {
          _finalValue = amount * 1.16;
        } else if (_enteredCurrency == widget._currencies[3] &&
            _convertedCurrency == widget._currencies[3]) {
          _finalValue = amount;
        } else if (_enteredCurrency == widget._currencies[3] &&
            _convertedCurrency == widget._currencies[0]) {
          _finalValue = amount * 79.48;
        } else if (_enteredCurrency == widget._currencies[3] &&
            _convertedCurrency == widget._currencies[1]) {
          _finalValue = amount * 1.13;
        } else if (_enteredCurrency == widget._currencies[3] &&
            _convertedCurrency == widget._currencies[2]) {
          _finalValue = amount * 0.86;
        }
      }

      _resultString =
          "$amount in $_enteredCurrency = $_finalValue in $_convertedCurrency";
    });
  }

  @override
  void initState() {
    super.initState();
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
                  value: _enteredCurrency,
                  key: 0,
                  context: context),
              SizedBox(
                height: 16.0,
              ),
              customRow(
                  text: "Select currecy to be converted with",
                  list: widget._currencies,
                  value: _convertedCurrency,
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
      {@required String labelText,
      @required String hintText,
      @required TextEditingController controller,
      @required Key formKey,
      @required BuildContext context}) {
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
          if (value.isEmpty) {
            return "Please enter some amount";
          }
        },
        controller: controller,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Decoration boxDecoration({@required BuildContext context}) => BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 2.0,
          style: BorderStyle.solid));

  Widget customRow({
    @required String text,
    @required List<String> list,
    @required String value,
    @required int key,
    @required BuildContext context,
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
            height: 56,
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
          {@required List<String> list,
          @required String value,
          @required int key,
          @required BuildContext context}) =>
      Container(
        decoration: boxDecoration(context: context),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButton<String>(
            items: list
                .map((String dropdownItem) => DropdownMenuItem<String>(
                      value: dropdownItem,
                      child: Text(
                        dropdownItem,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: (String dropdownItem) {
              setState(() {
                if (key == 0) {
                  _enteredCurrency = dropdownItem;
                } else if (key == 1) {
                  _convertedCurrency = dropdownItem;
                }
              });
            }),
      );

  Widget convertButton({@required BuildContext context}) => MaterialButton(
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

  Widget resultBox({@required BuildContext context}) => Container(
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
