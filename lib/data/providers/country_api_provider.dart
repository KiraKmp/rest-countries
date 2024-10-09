// lib/data/providers/country_api_provider.dart
import 'package:http/http.dart' as http;

class CountryApiProvider {
  Future<http.Response> fetchCountryData(String url) {
    return http.get(Uri.parse(url));
  }
}
