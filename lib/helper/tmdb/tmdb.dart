import 'dart:developer';
import 'package:movieapp/helper/constans/end_points.dart';
import 'package:movieapp/models/top_rated_model/top_rated_model.dart';
import 'package:movieapp/models/trending_model/trending_model.dart';
import 'package:movieapp/models/tv_model/tv_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbHelper {
  static TmdbHelper instance = TmdbHelper();
 late TrendingModel trendingModel;
late  TopRatedModel topRatedModel;
 late TvModel tvModel;

  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(EndPoints.apiKey, EndPoints.readAccessToken),
    logConfig: const ConfigLogger(
      showLogs: true, // Enable logging
      showErrorLogs: true,
    ),
  );

  Future<void> loadMovies() async {
    try {
      // Fetch Trending Movies
      Map<String, dynamic> trendingResult = await tmdbWithCustomLogs.v3.trending
          .getTrending() as Map<String, dynamic>;
      trendingModel = TrendingModel.fromJson(trendingResult); // Parse full JSON
      log('Trending: ${trendingModel.results?.length} movies loaded.');
    } catch (e) {
      log('Error tranding movies: $e');
    }
    try {
      // Fetch Trending Movies
      Map<String, dynamic> tvResult =
          await tmdbWithCustomLogs.v3.tv.getPopular() as Map<String, dynamic>;
      tvModel = TvModel.fromJson(tvResult); // Parse full JSON
      log('TV Shows: ${tvModel.results?.length} shows loaded.');
    } catch (e) {
      log('Error Tv movies: $e');
    }
    try {
      // Fetch Top Rated Movies
      Map<String, dynamic> topRatedResult = await tmdbWithCustomLogs.v3.movies
          .getTopRated() as Map<String, dynamic>;
      topRatedModel = TopRatedModel.fromJson(topRatedResult); // Parse full JSON
      log('Top Rated: ${topRatedModel.results?.length} movies loaded.');
    } catch (e) {
      log('Error Top Rated movies: $e');
    }

    // Fetch Popular TV Shows
  }
}
