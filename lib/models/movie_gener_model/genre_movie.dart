class GenreMovie {
  int? id;
  String? name;

  GenreMovie({this.id, this.name});

  factory GenreMovie.fromJson(Map<String, dynamic> json) => GenreMovie(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

}
