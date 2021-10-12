import 'dart:convert';

import 'package:currency_converter/model/convert_currency_request.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterRepository {
  Future<double?> convertCurrency(ConvertCurrencyRequest request) async {
    print(request.toString());
    try {
      http.Response response = await http.get(Uri.parse(request.toString()));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data['rates'].values.toList()[0];
      } else {
        throw Exception(
            "Error fetching the data for request ${request.toString()}");
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
