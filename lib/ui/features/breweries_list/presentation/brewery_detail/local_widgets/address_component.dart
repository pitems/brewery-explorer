import 'package:flutter/material.dart';
import 'header_element.dart';

class AddressComponent extends StatelessWidget {
  const AddressComponent({super.key, required this.addresses});

  final List<String> addresses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderElement(title: 'Addresses'),
        ...addresses.map(
          (address) => ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(address),
          ),
        ),
      ],
    );
  }
}
