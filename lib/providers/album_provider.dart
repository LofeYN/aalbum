// File: lib/providers/album_provider.dart

import 'package:flutter/material.dart';

class AlbumProvider with ChangeNotifier {
  // --- FAVORIT ---
  final Set<String> _favoriteAlbumIds = {};
  Set<String> get favoriteAlbumIds => _favoriteAlbumIds;

  void toggleFavorite(String albumId) {
    if (_favoriteAlbumIds.contains(albumId)) {
      _favoriteAlbumIds.remove(albumId);
    } else {
      _favoriteAlbumIds.add(albumId);
    }
    notifyListeners();
  }

  bool isFavorite(String albumId) {
    return _favoriteAlbumIds.contains(albumId);
  }

  // --- KERANJANG ---
  final Set<String> _cartAlbumIds = {};
  Set<String> get cartAlbumIds => _cartAlbumIds;

  void addToCart(String albumId) {
    _cartAlbumIds.add(albumId);
    notifyListeners();
  }

  // ### METHOD BARU DITAMBAHKAN DI SINI ###
  void removeFromCart(String albumId) {
    _cartAlbumIds.remove(albumId);
    notifyListeners();
  }

  // Method ini berguna untuk fitur "undo"
  void toggleCart(String albumId) {
    if (_cartAlbumIds.contains(albumId)) {
      _cartAlbumIds.remove(albumId);
    } else {
      _cartAlbumIds.add(albumId);
    }
    notifyListeners();
  }

  bool isInCart(String albumId) {
    return _cartAlbumIds.contains(albumId);
  }
}