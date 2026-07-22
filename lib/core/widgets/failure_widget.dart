import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.message, this.onRetry});
  final String message;
  final VoidCallback? onRetry;
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
                Icon(Icons.close_rounded, color: colorScheme.error, size: 110),
              ],
            ),
            const SizedBox(height: 16),
            Text('Something went wrong', style: textTheme.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(message, style: textTheme.bodyMedium, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              FilledButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Try again')),
              SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
