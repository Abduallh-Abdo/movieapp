import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/app_cubit/app_cubit.dart';
import 'package:movieapp/app_cubit/app_state.dart';
import 'package:movieapp/utils/text.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        List<dynamic> favorites = appCubit.favorites;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Favorites',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          body: favorites.isEmpty
              ? Center(
                  child: ModefiedText(
                    text: 'No Favorites Added',
                    size: 24,
                    color: Colors.white,
                  ),
                )
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favoriteMovie = favorites[index];
                    final moviePosterUrl = favoriteMovie['posterUrl'] ?? '';

                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: moviePosterUrl.isNotEmpty
                                        ? NetworkImage(moviePosterUrl)
                                        : const NetworkImage(
                                            'https://via.placeholder.com/150',
                                          ), // Placeholder if no image
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    appCubit.removeFromFavorite(favoriteMovie);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ModefiedText(
                            text: favoriteMovie['name'] ?? 'Unknown Title',
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                          ModefiedText(
                            text: favoriteMovie['description'] ??
                                'No description available',
                            size: 14,
                            color: Colors.grey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
