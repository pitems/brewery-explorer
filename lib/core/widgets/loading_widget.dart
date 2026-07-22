import 'package:flutter/material.dart';
import 'package:tech_challenge/core/widgets/beer_loader.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: BeerLoader(),
    );
  }
}
