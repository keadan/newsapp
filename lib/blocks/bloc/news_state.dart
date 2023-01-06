part of 'news_bloc.dart';

enum NewsStetStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  cleared,
  noInternet
}

class NewsState extends Equatable {
  @override
  List<Object> get props => [status, articles];
  final NewsStetStatus status;
  final List<Article> articles;
  final Exception? error;
  final Stream<List<Article>>? articlesStream;

  const NewsState.initial() : this._();
  const NewsState._({
    this.status = NewsStetStatus.initial,
    this.articles = const [],
    this.error,
    this.articlesStream,
  });
  NewsState asLoading() {
    return copyWith(
      status: NewsStetStatus.loading,
    );
  }

  NewsState onClear() {
    return copyWith(
      status: NewsStetStatus.cleared,
      articles: [],
    );
  }

  NewsState onRefresh() {
    return copyWith(
      articles: [],
      status: NewsStetStatus.loading,
    );
  }

  NewsState loadSuccess(List<Article> items, {Stream<List<Article>>? stream}) {
    return copyWith(
      articlesStream: stream,
      status: NewsStetStatus.loadSuccess,
      articles: items,
    );
  }

  NewsState loadFailure(Exception e) {
    return copyWith(
      status: NewsStetStatus.loadFailure,
      error: e,
    );
  }

  NewsState noConnection(List<Article> articles) {
    return copyWith(
      status: NewsStetStatus.noInternet,
      articles: articles,
    );
  }

  NewsState copyWith({
    NewsStetStatus? status,
    List<Article>? articles,
    Exception? error,
    Stream<List<Article>>? articlesStream,
  }) {
    return NewsState._(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      error: error ?? this.error,
      articlesStream: articlesStream ?? this.articlesStream,
    );
  }
}
