import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';

class WebsiteComponent extends StatelessWidget {
  const WebsiteComponent({super.key, required this.brewery, required this.onTap});

  final BreweryDetail brewery;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SizedBox(height: 8),
        FilledButton(
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BeerIcon(size: 32),
              const SizedBox(width: 8),
              const Text('Visit Website'),
              const SizedBox(width: 8),
              BeerIcon(size: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class BeerIcon extends StatelessWidget {
  const BeerIcon({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/link.svg',
      width: size,
      height: size,
    );
  }
}
