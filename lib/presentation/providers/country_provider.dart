// lib/presentation/providers/country_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_countries/data/models/country_model.dart';
import 'package:rest_countries/data/providers/country_api_provider.dart';

class CountryProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Country> _countryList = [];
  String _selectedFilter = 'None';

  bool get isLoading => _isLoading;
  List<Country> get countryList => _countryList;
  String get selectedFilter => _selectedFilter;

  final CountryApiProvider apiProvider = CountryApiProvider();

  CountryProvider() {
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<String> urls = [
        'https://restcountries.com/v3.1/translation/germany',
        'https://restcountries.com/v3.1/translation/india',
        'https://restcountries.com/v3.1/translation/israel',
        'https://restcountries.com/v3.1/translation/lanka',
        'https://restcountries.com/v3.1/translation/italy',
        'https://restcountries.com/v3.1/translation/china',
        'https://restcountries.com/v3.1/translation/korea',
      ];

      List<Country> tempCountryList = [];

      for (String url in urls) {
        var response = await apiProvider.fetchCountryData(url);
        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);

          // Parse each country in the response
          for (var countryJson in jsonData) {
            Country country = Country.fromJson(countryJson);
            tempCountryList.add(country);
          }
        } else {
          // Handle error response
          // You can use ScaffoldMessenger or another method to show errors
          print('Failed to load data for URL: $url');
        }
      }

      _countryList = tempCountryList;
      sortCountries();
    } catch (e) {
      print('Failed to fetch data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    sortCountries();
    notifyListeners();
  }

  void sortCountries() {
    if (_selectedFilter == 'A-Z') {
      _countryList.sort((a, b) => a.commonName.compareTo(b.commonName));
    } else if (_selectedFilter == 'Z-A') {
      _countryList.sort((a, b) => b.commonName.compareTo(a.commonName));
    }
    // No action needed for 'None'
  }
}
