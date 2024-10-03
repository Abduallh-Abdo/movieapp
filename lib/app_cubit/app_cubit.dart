import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/app_cubit/app_state.dart';
import 'package:movieapp/helper/tmdb/tmdb.dart';
import 'package:movieapp/models/movie_gener_model/genre_movie.dart';
import 'package:movieapp/models/tv_gener_model/genre_tv.dart';
import 'package:movieapp/widgets/components.dart';
import 'package:path/path.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  TmdbHelper tmdb = TmdbHelper.instance;
  bool isLoadingMovie = true;
  bool isLoadingGeners = true;
  bool? isOnline;
  bool isFavorite = false;

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Future<void> checkConnection() async {
    bool connectionStatus = await checkInternetConnection();

    isOnline = connectionStatus;
    emit(AppCheckConnectionState());
  }

  Future<void> loadMovies() async {
    await TmdbHelper.instance.loadMovies();
    await TmdbHelper.instance.loadGeners();

    isLoadingMovie = false;
    emit(AppLoadMoviesState());
  }

  // Future<void> loadGeners() async {
  //   isLoadingGeners = false;
  //   emit(AppLoadGenersState());
  // }

// Mapping Movie Genre IDs to Genre Names Safely
List<String> getMovieGenreNames(List<dynamic>? genreIds) {
  if (tmdb.movieGenerModel == null || genreIds == null) return [];

  return genreIds.map((id) {
    // Find the genre by ID or return an empty GenreMovie object if not found
    final genre = tmdb.movieGenerModel.genres?.firstWhere(
      (genre) => genre.id == id,
      orElse: () => GenreMovie(id: 0, name: ''), // Provide fallback empty GenreMovie
    );
    return genre?.name ?? ''; // If genre is found, return the name, else empty string
  }).toList();
}

// Mapping TV Genre IDs to Genre Names Safely
List<String> getTvGenreNames(List<dynamic>? genreIds) {
  if (tmdb.tvGenerModel == null || genreIds == null) return [];

  return genreIds.map((id) {
    // Find the genre by ID or return an empty GenreTV object if not found
    final genre = tmdb.tvGenerModel.genres?.firstWhere(
      (genre) => genre.id == id,
      orElse: () => GenreTV(id: 0, name: ''), // Provide fallback empty GenreTV
    );
    return genre?.name ?? ''; // If genre is found, return the name, else empty string
  }).toList();
}




  List<dynamic> favorites = [];

// Toggle the favorite state for the given item
  void toggleFavorite(Map<String, dynamic> item) {
    if (isInFavorites(item)) {
      removeFromFavorite(item);
    } else {
      addToFavorite(item);
    }
  }

// Check if an item is already in favorites
  bool isInFavorites(Map<String, dynamic> item) {
    return favorites.any((favorite) =>
        favorite['name'] == item['name'] &&
        favorite['posterUrl'] == item['posterUrl'] &&
        favorite['description'] == item['description']);
  }

// Add an item to the favorites list
  void addToFavorite(Map<String, dynamic> favorite) {
    if (!isInFavorites(favorite)) {
      favorites.add(favorite);

      log('Added to favorites: $favorites');
      defaultToast(
        msg: 'Added to favorites',
        state: ToastStates.success,
      );
      emit(AppAddFavoriteState());
    }
  }

// Remove an item from the favorites list
  void removeFromFavorite(Map<String, dynamic> favorite) {
    favorites.removeWhere((fav) =>
        fav['name'] == favorite['name'] &&
        fav['posterUrl'] == favorite['posterUrl'] &&
        fav['description'] == favorite['description']);

    log('Removed from favorites: $favorites');
    defaultToast(
      msg: 'Removed from favorites',
      state: ToastStates.error,
    );
    emit(AppRemoveFavoriteState());
  }
}
