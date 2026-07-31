import 'package:flutter/material.dart';
import 'package:tech_challenge/core/di/injection.dart';
import 'package:tech_challenge/core/navigation/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const BreweryExplorer());
}

class BreweryExplorer extends StatelessWidget {
  const BreweryExplorer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brewery Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AppPages.breweriesList(),
    );
  }
}
