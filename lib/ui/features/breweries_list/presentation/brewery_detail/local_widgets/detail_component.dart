import 'package:flutter/material.dart';
import 'header_element.dart';

class DetailComponent extends StatelessWidget {
  const DetailComponent({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
  });

  final String title;
  final IconData icon;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        children: [
          HeaderElement(title: title),
          const SizedBox(height: 8),
          ...data.map(
            (value) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
