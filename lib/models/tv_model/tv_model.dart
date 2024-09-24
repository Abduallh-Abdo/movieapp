import 'result.dart';

class TvModel {
  int? page;
  List<ResultTv>? results;
  int? totalPages;
  int? totalResults;

  TvModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        page: json['page'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => ResultTv.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int?,
        totalResults: json['total_results'] as int?,
      );
}
