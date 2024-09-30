import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/app_cubit/app_cubit.dart';
import 'package:movieapp/app_cubit/app_state.dart';
import 'package:movieapp/utils/text.dart';

class DescriptionScreen extends StatelessWidget {
  final String name;
  final String description;
  final String bannerUrl;
  final String posterUrl;
  final String vote;
  final String launchOn;

  const DescriptionScreen({
    super.key,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.vote,
    required this.launchOn,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          body: ListView(
            children: [
              // Banner Image
              bannerUrl.isNotEmpty
                  ? Stack(
                      children: [
                        Image.network(
                          bannerUrl,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: ModefiedText(
                            text: '⭐ Average Rating - $vote',
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 250,
                      color: Colors.grey, // Fallback for missing image
                    ),
              const SizedBox(height: 50),

              // Movie Title and Favorite Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ModefiedText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: name,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      appCubit.toggleFavorite({
                        'name': name,
                        'posterUrl': posterUrl,
                        'description': description,
                      });
                    },
                    icon: Icon(
                      appCubit.isInFavorites({
                        'name': name,
                        'posterUrl': posterUrl,
                        'description': description,
                      })
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: appCubit.isInFavorites({
                        'name': name,
                        'posterUrl': posterUrl,
                        'description': description,
                      })
                          ? Colors.red
                          : Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Release Date
              ModefiedText(
                text: 'Release Date: $launchOn',
                size: 18,
                color: Colors.white,
              ),
              const SizedBox(height: 30),

              // Poster Image and Description
              Row(
                children: [
                  posterUrl.isNotEmpty
                      ? Image.network(
                          posterUrl,
                          height: 250,
                        )
                      : Container(
                          height: 250,
                          color: Colors.grey, // Fallback for missing poster
                        ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ModefiedText(
                        text: description,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
