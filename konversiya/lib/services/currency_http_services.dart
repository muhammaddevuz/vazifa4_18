import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:konversiya/models/currency.dart';
import 'package:konversiya/utils/country_codes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyServices {
  Future<List<Currency>> getInfotmation() async {
    Uri url = Uri.parse(
        "https://api.currencyapi.com/v3/latest?apikey=cur_live_f5ItVMSFjiN0hvfA4CpeuN1RZRmu7zlTONuJFb5D");
    List<Currency> loadedCurrency = [];
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    data['data'].forEach((key, value) {
      if (CountryCodes.currencyCode[value['code']]!=null) {
        loadedCurrency.add(Currency.fromJson(value));
      }
    });

    return loadedCurrency;
  }
}

Future<void> saveLocation(String location) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('location', location);
}
