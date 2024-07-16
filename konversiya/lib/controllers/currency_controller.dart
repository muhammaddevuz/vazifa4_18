import 'package:konversiya/models/currency.dart';
import 'package:konversiya/services/currency_http_services.dart';

class CurrencyController {
  final currencyServices = CurrencyServices();

  Future<List<Currency>> getInformation() async {
    List<Currency> currency = await currencyServices.getInfotmation();

    return currency;
  }
}