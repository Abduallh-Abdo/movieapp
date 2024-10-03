import 'genre_movie.dart';

class MovieGenerModel {
  List<GenreMovie>? genres;

  MovieGenerModel({this.genres});

  factory MovieGenerModel.fromJson(Map<String, dynamic> json) {
    return MovieGenerModel(
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
