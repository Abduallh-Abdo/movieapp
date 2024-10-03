import 'package:flutter/material.dart';
import 'package:movieapp/models/tv_model/result.dart';
import 'package:movieapp/utils/text.dart';

class TvMovies extends StatelessWidget {
  const TvMovies({
    super.key,
    required this.movie,
    required this.text,
    required this.onTap, // Add onTap callback
  });

  final List<ResultTv>? movie;
  final String text;
  final Function(ResultTv) onTap; // Callback that accepts the selected movie

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
                      final movieTitle = movie![index].name ?? 'Loading ⏳';
                      final moviePosterUrl = movie![index].posterPath != null
                          ? 'https://image.tmdb.org/t/p/w500${movie![index].posterPath}'
                          : '';

                      return GestureDetector(
                        onTap: () => onTap(movie![index]), // Trigger onTap callback
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
                                      borderRadius: BorderRadius.circular(10), // Rounded corners
                                      image: DecorationImage(
                                        image: NetworkImage(moviePosterUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
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
