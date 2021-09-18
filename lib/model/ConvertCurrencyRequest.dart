class ConvertCurrencyRequest {
  const ConvertCurrencyRequest({
    required this.fromCode,
    required this.toCode,
    required this.amount,
  });

  static final String api = "https://api.frankfurter.app/latest";
  final String fromCode;
  final String toCode;
  final double amount;

  @override
  String toString() {
    return api + "?from=$fromCode&to=$toCode&amount=$amount";
  }
}
