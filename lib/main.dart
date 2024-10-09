import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_countries/presentation/pages/home_page.dart';
import 'package:rest_countries/presentation/providers/country_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Info App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
