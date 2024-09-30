import 'package:flutter/material.dart';
import 'package:movieapp/models/tv_model/result.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/views/description/description_screen.dart';

class TvMovies extends StatelessWidget {
  const TvMovies({
    super.key,
    required this.movie,
    required this.text,
  });

  final List<ResultTv>? movie;
  final String text;

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
                      final movieTitle = movie![index].name ?? 'Loading';
                      final moviePosterUrl = movie![index].posterPath != null
                          ? 'https://image.tmdb.org/t/p/w500${movie![index].posterPath}'
                          : '';
                      // final isMovieFavorite = appCubit.isFavorite(movieTitle);

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
                                    movie![index].firstAirDate ?? 'Unknown',
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 240,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 200,
                                    width: 300,
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
                                  //     onPressed: () => appCubit.addToFavorite({
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
