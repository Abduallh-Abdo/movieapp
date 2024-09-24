
class Result {
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? originalLanguage;
  List<dynamic>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Result({
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json['backdrop_path'] as String?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        originalTitle: json['original_title'] as String?,
        overview: json['overview'] as String?,
        posterPath: json['poster_path'] as String?,
        mediaType: json['media_type'] as String?,
        adult: json['adult'] as bool?,
        originalLanguage: json['original_language'] as String?,
        genreIds: json['genre_ids'] as List<dynamic>?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        releaseDate: json['release_date'] as String?,
        video: json['video'] as bool?,
        voteAverage: (json['vote_average'] as num?)?.toDouble(),
        voteCount: json['vote_count'] as int?,
      );

}
