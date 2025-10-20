// File: lib/models/product.dart

class Album {
  final String id;
  final String name;
  final String artist;
  final int price;
  final String imageUrl;
  final String genre;
  final int releaseYear;
  final int trackCount;
  final String description;
  final double rating;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    required this.price,
    required this.imageUrl,
    required this.genre,
    required this.releaseYear,
    required this.trackCount,
    required this.description,
    this.rating = 0.0,
  });
}

class Vinyl extends Album {
  final String vinylColor;
  final bool limitedEdition;

  Vinyl({
    required super.id,
    required super.name,
    required super.artist,
    required super.price,
    required super.imageUrl,
    required super.genre,
    required super.releaseYear,
    required super.trackCount,
    required super.description,
    super.rating,
    required this.vinylColor,
    required this.limitedEdition,
  });
}

// PASTIKAN TIDAK ADA "class AlbumProvider { ... }" DI FILE INI