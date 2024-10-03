class GenreTV {
  int? id;
  String? name;

  GenreTV({this.id, this.name});

  factory GenreTV.fromJson(Map<String, dynamic> json) => GenreTV(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );
}
