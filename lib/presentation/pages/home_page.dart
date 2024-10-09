// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rest_countries/presentation/providers/country_provider.dart';

class HomePage extends StatelessWidget {
  // List of sorting options
  final List<String> sortingOptions = ['None', 'A-Z', 'Z-A'];

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Information'),
        actions: [
          DropdownButton<String>(
            value: countryProvider.selectedFilter,
            icon: const Icon(Icons.filter_list, color: Colors.white),
            dropdownColor: Colors.white,
            underline: Container(),
            items: sortingOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  'Sort $value',
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              countryProvider.setSelectedFilter(newValue!);
            },
          ),
        ],
      ),
      body: countryProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : countryProvider.countryList.isEmpty
              ? const Center(child: Text('No data available.'))
              : ListView.builder(
                  itemCount: countryProvider.countryList.length,
                  itemBuilder: (context, index) {
                    final country = countryProvider.countryList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: country.flagUrl,
                          placeholder: (context, url) => const SizedBox(
                              width: 50,
                              height: 50,
                              child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 50,
                          height: 50,
                        ),
                        title: Text(country.commonName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Official Name: ${country.officialName}'),
                            Text(
                              'Currency: ${country.currencyName} (${country.currencyCode})',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
