class Currency {
  final String _name;
  final String _symbol;

  const Currency({required String name, required String symbol})
      : this._name = name,
        this._symbol = symbol,
        assert(name != null),
        assert(symbol != null);

  String get name => _name;
  String get symbol => _symbol;
}
