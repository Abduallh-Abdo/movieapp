import 'genre_tv.dart';

class TvGenerModel {
  List<GenreTV>? genres;

  TvGenerModel({this.genres});

  factory TvGenerModel.fromJson(Map<String, dynamic> json) => TvGenerModel(
        genres: (json['genres'] as List<dynamic>?)
            ?.map((e) => GenreTV.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
