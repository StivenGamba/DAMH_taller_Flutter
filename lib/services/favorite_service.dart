import 'package:flutter/material.dart';

class FavoriteService extends ChangeNotifier {
  // Lista de IDs de productos favoritos
  final List<int> _favoritesIds = [];

  // Getter para obtener la lista de IDs
  List<int> get favoritesIds => _favoritesIds;

  // Verificar si un producto está en favoritos
  bool isFavorite(int productId) {
    return _favoritesIds.contains(productId);
  }

  // Añadir o quitar de favoritos
  void toggleFavorite(int productId) {
    if (isFavorite(productId)) {
      _favoritesIds.remove(productId);
    } else {
      _favoritesIds.add(productId);
    }
    notifyListeners();
  }

  // Limpiar todos los favoritos
  void clearAll() {
    _favoritesIds.clear();
    notifyListeners();
  }
}
