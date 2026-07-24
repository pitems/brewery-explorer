import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class HeaderElement extends StatelessWidget {
  const HeaderElement({super.key, required this.title, this.size});

  final String title;
  final double? size;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size ?? 15,
          ),
        ),
        DottedLine(
          dashLength: 6,
          dashGapLength: 4,
        ),
      ],
    );
  }
}
