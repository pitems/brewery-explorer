import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge/ui/features/favorites/data/favorite_datasource_impl.dart';

void main() {
  late InMemoryFavoritesDataSource dataSource;

  setUp(() {
    dataSource = InMemoryFavoritesDataSource();
  });

  test('starts with no favorites', () {
    expect(dataSource.getFavorites(), isEmpty);
  });

  test('saves a favorite and does not duplicate it', () async {
    final firstSave = await dataSource.saveFavorite('brewery-1');
    final secondSave = await dataSource.saveFavorite('brewery-1');

    expect(firstSave, isTrue);
    expect(secondSave, isFalse);
    expect(dataSource.getFavorites(), hasLength(1));
    expect(dataSource.getFavorites().single.breweryId, 'brewery-1');
  });

  test('removes an existing favorite', () async {
    await dataSource.saveFavorite('brewery-1');

    final removed = await dataSource.removeFavorite('brewery-1');

    expect(removed, isTrue);
    expect(dataSource.getFavorites(), isEmpty);
  });
}
