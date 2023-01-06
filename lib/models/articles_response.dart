import 'package:equatable/equatable.dart';

import 'article.dart';

class ArticlesResponse extends Equatable {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  const ArticlesResponse({this.status, this.totalResults, this.articles});

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      ArticlesResponse(
        status: json['status'] as String?,
        totalResults: json['totalResults'] as int?,
        articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles?.map((e) => e.toJson()).toList(),
      };

  ArticlesResponse copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    return ArticlesResponse(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalResults, articles];
}
