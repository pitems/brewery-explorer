import 'package:flutter/material.dart';
import 'header_element.dart';

class PhoneComponent extends StatelessWidget {
  const PhoneComponent({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderElement(title: 'Phone'),
        ListTile(title: Text(phoneNumber)),
      ],
    );
  }
}
