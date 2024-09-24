import 'package:flutter/material.dart';
import 'package:movieapp/helper/tmdb/tmdb.dart';
import 'package:movieapp/helper/to_favorite.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/views/favorites/favorite.dart';
import 'package:movieapp/widgets/trending.dart';
import 'package:movieapp/widgets/top_rated.dart';
import 'package:movieapp/widgets/tv_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TmdbHelper tmdb = TmdbHelper.instance;
  bool isLoading = true;
  List<dynamic> favorite = ToFavorite.favorites; // Store movie details as favorites

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    await TmdbHelper.instance.loadMovies();
    setState(() {
      isLoading = false; // Update loading status after data is loaded
    });
  }

  // Function to add/remove a movie from the favorites
 

  bool isFavorite(String movieName) {
    return favorite.any((movie) => movie['name'] == movieName,);
  }

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => const FavoritesScreen(
                    
                  ),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                TvMovies(
                  text: 'Popular TV Shows',
                  movie: tmdb.tvModel.results, // Use model's parsed data

                  toggleFavorite: ToFavorite.addToFavorite, 
                  isFavorite: isFavorite, // Pass function to check if favorite
                ),
                const SizedBox(height: 10),
                TopRated(
                  text: 'Top Rated Movies',
                  movie: tmdb.topRatedModel.results,
                  toggleFavorite: ToFavorite.addToFavorite, 
                  isFavorite: isFavorite, 
                ),
                const SizedBox(height: 10),
                TrendingMovies(
                  text: 'Trending Movies',
                  movie: tmdb.trendingModel.results, // Use model's parsed data
                  // posterPath: 'poster_path',
                  // backdropPath: 'backdrop_path',
                  // title: 'title',
                  toggleFavorite: ToFavorite.addToFavorite, 
                  isFavorite: isFavorite, // Pass function to check if favorite
                ),
              ],
            ),
    );
  }
}
