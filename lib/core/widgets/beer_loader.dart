import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeerLoader extends StatefulWidget {
  const BeerLoader({
    super.key,
    this.size = 56,
    this.duration = const Duration(milliseconds: 900),
  });

  final double size;
  final Duration duration;

  @override
  State<BeerLoader> createState() => _BeerLoaderState();
}

class _BeerLoaderState extends State<BeerLoader>
    with SingleTickerProviderStateMixin {
  static const _beerAssets = [
    'assets/beer1.svg',
    'assets/beer2.svg',
    'assets/beer3.svg',
    'assets/beer4.svg',
  ];

  late final AnimationController _controller;
  var _currentBeer = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addStatusListener(_handleAnimationStatus)
      ..forward();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }

    setState(() {
      _currentBeer = (_currentBeer + 1) % _beerAssets.length;
    });

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_handleAnimationStatus)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      liveRegion: true,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: SvgPicture.asset(
          _beerAssets[_currentBeer],
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}
