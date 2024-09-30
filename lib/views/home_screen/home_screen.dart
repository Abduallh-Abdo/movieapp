import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/app_cubit/app_cubit.dart';
import 'package:movieapp/app_cubit/app_state.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/views/favorites/favorite.dart';
import 'package:movieapp/widgets/trending.dart';
import 'package:movieapp/widgets/top_rated.dart';
import 'package:movieapp/widgets/tv_movies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Check if a movie is favorited
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
          body: appCubit.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    TvMovies(
                      text: 'Popular TV Shows',
                      movie: appCubit.tmdb.tvModel.results,
                    ),
                    const SizedBox(height: 10),
                    TopRated(
                      text: 'Top Rated Movies',
                      movie: appCubit.tmdb.topRatedModel.results,

                    ),
                    const SizedBox(height: 10),
                    TrendingMovies(
                      text: 'Trending Movies',
                      movie: appCubit.tmdb.trendingModel
                          .results, // Use model's parsed data
                     
                    ),
                  ],
                ),
        );
      },
    );
  }
}
