import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/app_cubit/app_cubit.dart';
import 'package:movieapp/app_cubit/app_state.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/views/favorites/favorite.dart';
import 'package:movieapp/widgets/trending.dart';
import 'package:movieapp/widgets/top_rated.dart';
import 'package:movieapp/widgets/tv_movies.dart';
import 'package:movieapp/views/description/description_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: ModefiedText(
              text: 'Movies App',
              color: Colors.white,
              size: 24,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/favorite.png',
                  width: 30,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: appCubit.isLoadingMovie
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    // Popular TV Shows
                    TvMovies(
                      text: 'Popular TV Shows',
                      movie: appCubit.tmdb.tvModel.results,
                      onTap: (tvShow) {
                        // Navigate to DescriptionScreen for TV show
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptionScreen(
                              name: tvShow.name ?? 'loading ⏳',
                              description:
                                  tvShow.overview ?? 'No description available',
                              bannerUrl:
                                  'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                              posterUrl:
                                  'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                              vote: tvShow.voteAverage?.toString() ?? 'N/A',
                              launchOn: tvShow.firstAirDate ?? 'Unknown',
                              genreIds:
                                  tvShow.genreIds, // Pass genre IDs for TV show
                              isTvShow: true, // This is a TV show
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // Top Rated Movies
                    TopRated(
                      text: 'Top Rated Movies',
                      movie: appCubit.tmdb.topRatedModel.results,
                      onTap: (movie) {
                        // Navigate to DescriptionScreen for movie
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptionScreen(
                              name: movie.title ?? 'loading ⏳',
                              description:
                                  movie.overview ?? 'No description available',
                              bannerUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                              posterUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              vote: movie.voteAverage?.toString() ?? 'N/A',
                              launchOn: movie.releaseDate ?? 'Unknown',
                              genreIds:
                                  movie.genreIds, // Pass genre IDs for movie
                              isTvShow: false, // This is a movie
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // Trending Movies
                    TrendingMovies(
                      text: 'Trending Movies',
                      movie: appCubit.tmdb.trendingModel.results,
                      onTap: (movie) {
                        // Navigate to DescriptionScreen for movie
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptionScreen(
                              name: movie.title ?? 'loading ⏳',
                              description:
                                  movie.overview ?? 'No description available',
                              bannerUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                              posterUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              vote: movie.voteAverage?.toString() ?? 'N/A',
                              launchOn: movie.releaseDate ?? 'Unknown',
                              genreIds:
                                  movie.genreIds, // Pass genre IDs for movie
                              isTvShow: false, // This is a movie
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}
