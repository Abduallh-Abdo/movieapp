import 'result.dart';

class TopRatedModel {
  int? page;
  List<ResultToRated>? results;
  int? totalPages;
  int? totalResults;

  TopRatedModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TopRatedModel.fromJson(Map<String, dynamic> json) => TopRatedModel(
        page: json['page'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => ResultToRated.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int?,
        totalResults: json['total_results'] as int?,
      );
}
