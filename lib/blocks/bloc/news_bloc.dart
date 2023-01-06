import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:news/models/article.dart';
import 'package:news/models/articles_response.dart';
import 'package:news/repository/remote/API.dart';
import 'package:rxdart/rxdart.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/news_db.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final newsDatabase = NewsDatabase();
  ConnectivityResult? connectivityResult;
  late StreamSubscription<ConnectivityResult> subscription;
  late NewsApiService newsService;

  final BehaviorSubject<ArticlesResponse> firstResponse =
      BehaviorSubject<ArticlesResponse>();
  final BehaviorSubject<ArticlesResponse> secondResponse =
      BehaviorSubject<ArticlesResponse>();

  @override
  Future<void> close() async {
    firstResponse.close();
    secondResponse.close();
    super.close();
  }

  NewsBloc() : super(const NewsState.initial()) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityResult = result;
    });

    final chopper = ChopperClient(
      baseUrl: Uri.parse("https://newsapi.org"),
      services: [NewsApiService.create()],
    );

    newsService = chopper.getService<NewsApiService>();
    on<LoadNews>(_onLoadStarted);
    on<ClearData>(_onClear);
    on<RefreshData>(_onRefresh);
  }
  void _onLoadStarted(LoadNews event, Emitter<NewsState> emit) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      final data = await getLocalArticles();

      emit(state.noConnection(data));

      return;
    }
    try {
      emit(state.asLoading());
      final firstApiResponse = await newsService.getArticles('health');
      final firstArticlesResponce =
          ArticlesResponse.fromJson(jsonDecode(firstApiResponse.body));
      final secondApiResponse = await newsService.getArticles('sport');
      final secondArticlesResponce =
          ArticlesResponse.fromJson(jsonDecode(secondApiResponse.body));

      firstResponse.sink.add(firstArticlesResponce);
      secondResponse.sink.add(secondArticlesResponce);
      //final data = articlesResponce.articles ?? [];
      emit(state.loadSuccess([], stream: getNews));
      saveToLocal(firstArticlesResponce.articles ?? []);
    } on Exception catch (e) {
      emit(state.loadFailure(e));
    }
  }

  Stream<List<Article>> get getNews =>
      Rx.combineLatest2(firstResponse.stream, secondResponse.stream,
          (ArticlesResponse firstResponse, ArticlesResponse secondResponse) {
        return (firstResponse.articles ?? []) + (secondResponse.articles ?? []);
      });

  void _onClear(ClearData event, Emitter<NewsState> emit) async {
    emit(state.asLoading());
    await newsDatabase.clearDatabase();
    try {
      emit(state.onClear());
    } on Exception catch (e) {
      emit(state.loadFailure(e));
    }
  }

  void _onRefresh(RefreshData event, Emitter<NewsState> emit) async {
    try {
      emit(state.asLoading());
      final firstApiResponse = await newsService.getArticles('health');
      final firstArticlesResponce =
          ArticlesResponse.fromJson(jsonDecode(firstApiResponse.body));
      final secondApiResponse = await newsService.getArticles('sport');
      final secondArticlesResponce =
          ArticlesResponse.fromJson(jsonDecode(secondApiResponse.body));

      firstResponse.sink.add(firstArticlesResponce);
      secondResponse.sink.add(secondArticlesResponce);
      //final data = articlesResponce.articles ?? [];
      emit(state.loadSuccess([], stream: getNews));
      saveToLocal(firstArticlesResponce.articles ?? []);
    } on Exception catch (e) {
      emit(state.loadFailure(e));
    }
  }

  saveToLocal(List<Article> articles) async {
    await newsDatabase.clearDatabase();
    for (final article in articles) {
      final entity = LocalArticle(
          title: article.title ?? "",
          author: article.author ?? "",
          description: article.description ?? "",
          imageUrl: article.urlToImage ?? "");
      newsDatabase.addArticle(entity);
    }
  }

  Future<List<Article>> getLocalArticles() async {
    List<Article> articles = [];
    final localArticles = await newsDatabase.getArticles();
    for (final localArticle in localArticles) {
      final jsonLocl = localArticle.toJson();
      final article = Article.fromJson(jsonLocl);
      articles.add(article);
    }
    return articles;
  }
}
