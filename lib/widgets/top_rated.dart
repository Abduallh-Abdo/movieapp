import 'package:flutter/material.dart';
import 'package:movieapp/models/top_rated_model/result.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/views/description/description_screen.dart';

class TopRated extends StatelessWidget {
  const TopRated({
    super.key,
    required this.movie,
    required this.text,
    required this.toggleFavorite, // Function to toggle favorites
    required this.isFavorite, // Function to check if the movie is a favorite
  });

  final List<ResultToRated>? movie;
  final String text;

  final Function(Map<String, dynamic>) toggleFavorite;
  final bool Function(String)
      isFavorite; // Checks if the movie is a favorite by its name

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModefiedText(
            text: text,
            size: 26,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          movie!.isEmpty
              ? Center(
                  child: ModefiedText(
                    text: 'No Movies Found',
                    size: 20,
                    color: Colors.white,
                  ),
                )
              : SizedBox(
                  height: 300,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: movie!.length,
                    itemBuilder: (context, index) {
                      final movieTitle = movie![index].title ?? 'Loading';
                      final moviePosterUrl = movie![index].posterPath != null
                          ? 'https://image.tmdb.org/t/p/w500${movie![index].posterPath}'
                          : '';

                      // Check if this movie is already in favorites
                      final isMovieFavorite = isFavorite(movieTitle);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionScreen(
                                name: movieTitle,
                                description: movie![index].overview ??
                                    'No description available',
                                bannerUrl:
                                    'https://image.tmdb.org/t/p/w500${movie![index].backdropPath}',
                                posterUrl: moviePosterUrl,
                                vote: movie![index].voteAverage?.toString() ??
                                    'N/A',
                                launchOn:
                                    movie![index].releaseDate ?? 'Unknown',
                                toggleFavorite: toggleFavorite,
                                isFavorite: isMovieFavorite,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    height:
                                        200, // Adjusted height for image display
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded corners
                                      image: DecorationImage(
                                        image: NetworkImage(moviePosterUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Favorite Icon in the top right corner of the movie card
                                  // Positioned(
                                  //   right: 10,
                                  //   top: 10,
                                  //   child: IconButton(
                                  //     onPressed: () => toggleFavorite({
                                  //       'name': movieTitle,
                                  //       'posterUrl': moviePosterUrl,
                                  //       'description': movie![index].overview ??
                                  //           'No description available',
                                  //     }),
                                  //     icon: Icon(
                                  //       isMovieFavorite
                                  //           ? Icons.favorite
                                  //           : Icons.favorite_border,
                                  //       color: isMovieFavorite
                                  //           ? Colors.red
                                  //           : Colors.white,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              ModefiedText(
                                text: movieTitle,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
