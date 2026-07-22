import 'package:flutter/material.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';
import 'header_element.dart';

class WebsiteComponent extends StatelessWidget {
  const WebsiteComponent({super.key, required this.brewery, required this.onTap});

  final BreweryDetail brewery;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderElement(title: 'Website'),
        ListTile(
          title: Text(brewery.website!),
          onTap: onTap,
        ),
      ],
    );
  }
}
