class FavoriteEntity {
  const FavoriteEntity({required this.breweryId, required this.isFavorite, this.tags});

  final String breweryId;
  final bool isFavorite;
  final List<String>? tags;

  FavoriteEntity copyWith({
    String? breweryId,
    bool? isFavorite,
    List<String>? tags,
  }) {
    return FavoriteEntity(
      breweryId: breweryId ?? this.breweryId,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
    );
  }
}
