import 'dart:developer';

abstract class ToFavorite {
  static List<dynamic> favorites = [];

  static void addToFavorite(dynamic favorite) {
    if (!favorites.contains(favorite)) {
      favorites.add(favorite);
    }
    log(favorites.toString());
  }

  static void removeToFavorite(dynamic favorite) {
    favorites.removeAt(favorite);
    log(favorites.toString());
  }
}
