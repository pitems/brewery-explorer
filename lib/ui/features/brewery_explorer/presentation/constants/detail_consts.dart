class BreweryDetailUxHelper {
  static const _beerAssets = [
    'assets/beer1.svg',
    'assets/beer2.svg',
    'assets/beer3.svg',
    'assets/beer4.svg',
  ];

  String beerAsset(String name) {
    final index = name.hashCode.abs() % _beerAssets.length;
    return _beerAssets[index];
  }
}
