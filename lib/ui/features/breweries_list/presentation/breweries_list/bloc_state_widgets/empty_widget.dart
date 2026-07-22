import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(-5, 0),
                  child: SvgPicture.asset('assets/nobeer.svg', width: 110, height: 110),
                ),
                Icon(Icons.question_mark, color: colorScheme.error, size: 110),
              ],
            ),
            const SizedBox(height: 16),
            Text('Ups, it seems there is no data here', style: textTheme.titleMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
