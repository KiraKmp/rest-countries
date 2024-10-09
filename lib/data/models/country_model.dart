// lib/data/models/country_model.dart
class Country {
  final String commonName;
  final String officialName;
  final String currencyCode;
  final String currencyName;
  final String flagUrl;

  Country({
    required this.commonName,
    required this.officialName,
    required this.currencyCode,
    required this.currencyName,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // Extract common and official names
    String commonName = json['name']['common'] ?? 'Unknown';
    String officialName = json['name']['official'] ?? 'Unknown';

    // Extract currency code and name
    String currencyCode = 'N/A';
    String currencyName = 'N/A';

    if (json['currencies'] != null && json['currencies'].isNotEmpty) {
      Map<String, dynamic> currencies = json['currencies'];
      currencyCode = currencies.keys.first;
      currencyName = currencies[currencyCode]['name'] ?? 'N/A';
    }

    // Extract flag URL
    String flagUrl = json['flags']?['png'] ?? '';

    return Country(
      commonName: commonName,
      officialName: officialName,
      currencyCode: currencyCode,
      currencyName: currencyName,
      flagUrl: flagUrl,
    );
  }
}
