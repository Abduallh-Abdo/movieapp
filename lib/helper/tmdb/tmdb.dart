import 'dart:developer';
import 'package:movieapp/helper/constans/end_points.dart';
import 'package:movieapp/models/movie_gener_model/movie_gener_model.dart';
import 'package:movieapp/models/top_rated_model/top_rated_model.dart';
import 'package:movieapp/models/trending_model/trending_model.dart';
import 'package:movieapp/models/tv_gener_model/tv_gener_model.dart';
import 'package:movieapp/models/tv_model/tv_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbHelper {
  static final TmdbHelper instance = TmdbHelper();

  late TrendingModel trendingModel;
  late TopRatedModel topRatedModel;
  late TvModel tvModel;
  late MovieGenerModel movieGenerModel;
  late TvGenerModel tvGenerModel;


  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(EndPoints.apiKey, EndPoints.readAccessToken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  // Fetch and save movies into the database
  Future<void> loadMovies() async {
    try {
      // Fetch Trending Movies
      Map<String, dynamic> trendingResult = await tmdbWithCustomLogs.v3.trending
          .getTrending() as Map<String, dynamic>;
      trendingModel = TrendingModel.fromJson(trendingResult);
      // log('Trending: ${trendingModel.results?.length} movies loaded.');
    } catch (e) {
      log('Error loading trending movies: $e');
    }

    try {
      // Fetch Popular TV Shows
      Map<String, dynamic> tvResult =
          await tmdbWithCustomLogs.v3.tv.getPopular() as Map<String, dynamic>;
      tvModel = TvModel.fromJson(tvResult);
      // log('TV Shows: ${tvModel.results?.length} shows loaded.');
    } catch (e) {
      log('Error loading TV shows: $e');
    }

    try {
      // Fetch Top Rated Movies
      Map<String, dynamic> topRatedResult = await tmdbWithCustomLogs.v3.movies
          .getTopRated() as Map<String, dynamic>;
      topRatedModel = TopRatedModel.fromJson(topRatedResult);
      // log('Top Rated: ${topRatedModel.results?.length} movies loaded.');
    } catch (e) {
      log('Error loading top-rated movies: $e');
    }

    // Save fetched data into the SQLite database
    // saveInDB();
  }

  // Save fetched movies into the SQLite database

  // Future<void> saveInDB() async {
  //   for (int i = 0; i < 3; i++) {
  //     // Insert trending movies
  //     SqfliteDb.instance.insertDB(
  //       title: trendingModel.results?[i].title ?? '',
  //       image: trendingModel.results?[i].posterPath ?? '',
  //       description: trendingModel.results?[i].overview ?? '',
  //     );

  //     // Insert popular TV shows
  //     SqfliteDb.instance.insertDB(
  //       title: tvModel.results?[i].name ?? '',
  //       image: tvModel.results?[i].posterPath ?? '',
  //       description: tvModel.results?[i].overview ?? '',
  //     );

  //     // Insert top-rated movies
  //     SqfliteDb.instance.insertDB(
  //       title: topRatedModel.results?[i].title ?? '',
  //       image: topRatedModel.results?[i].posterPath ?? '',
  //       description: topRatedModel.results?[i].overview ?? '',
  //     );
  //   }
  // }
  Future<void> loadGeners() async {
    // Movie list genres
    try {
      Map<String, dynamic> movieListGenerResult =
          await tmdbWithCustomLogs.v3.genres.getMovieList()
              as Map<String, dynamic>;
      movieGenerModel = MovieGenerModel.fromJson(movieListGenerResult);
      log('Movie Genres: ${movieListGenerResult.length.toString()}');
    } catch (e) {
      log('Error fetching movie genres: $e');
    }

    // TV list genres
    try {
      Map<String, dynamic> tvListGenerResult =
          await tmdbWithCustomLogs.v3.genres.getTvlist()
              as Map<String, dynamic>;
      tvGenerModel = TvGenerModel.fromJson(tvListGenerResult);
      log('TV Genres: ${tvListGenerResult.length.toString()}');
    } catch (e) {
      log('Error fetching TV genres: $e');
    }
  }
 
}
