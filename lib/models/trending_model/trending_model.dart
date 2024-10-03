import 'result.dart';

class TrendingModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  TrendingModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        page: json['page'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int?,
        totalResults: json['total_results'] as int?,
      );
}
