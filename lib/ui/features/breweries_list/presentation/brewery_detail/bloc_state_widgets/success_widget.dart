import 'package:flutter/material.dart';
import 'package:tech_challenge/core/navigation/url_helper.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';
import '../local_widgets/address_component.dart';
import '../local_widgets/header_element.dart';
import '../local_widgets/phone_component.dart';
import '../local_widgets/website_component.dart';

class SuccessDetail extends StatelessWidget {
  const SuccessDetail({super.key, required this.brewery});

  final BreweryDetail brewery;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HeaderElement(title: brewery.name),
        const SizedBox(height: 20),
        AddressComponent(addresses: brewery.addresses),
        const SizedBox(height: 20),
        if (hasValue(brewery.phone)) PhoneComponent(phoneNumber: brewery.phone!),
        if (hasValue(brewery.website)) WebsiteComponent(brewery: brewery,onTap: ()=> _openWebsite(context),),
      ],
    );
  }

  bool hasValue(String? value) => value != null && value.trim().isNotEmpty;

  Future<void> _openWebsite(BuildContext context) async {
    final opened = await UrlHelper.openWebsite(brewery.website!);

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unable to open website')));
    }
  }
}
