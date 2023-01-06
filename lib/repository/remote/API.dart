import 'dart:convert';
import 'package:news/models/articles_response.dart';
import 'package:chopper/chopper.dart';

part 'API.chopper.dart';

// class API {
//   API._privateConstructor();
//   static final API _instance = API._privateConstructor();
//   static API get instance => _instance;

//   Future<ArticlesResponse> getArticles() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a7d93afad0b0494a9e10e5dbcd6f939c'));
//       final articles = ArticlesResponse.fromJson(jsonDecode(response.body));
//       return articles;
//     } catch (e) {
//       return Future.error(Exception(e));
//     }
//   }

//   Future<ArticlesResponse> getArticles2() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a7d93afad0b0494a9e10e5dbcd6f939c'));
//       final articles = ArticlesResponse.fromJson(jsonDecode(response.body));
//       return articles;
//     } catch (e) {
//       return Future.error(Exception(e));
//     }
//   }
// }

@ChopperApi(
    baseUrl: '/v2/top-headlines?apiKey=a7d93afad0b0494a9e10e5dbcd6f939c')
abstract class NewsApiService extends ChopperService {
  @Get()
  Future<Response> getArticles(@Query('category') String sources);

  static NewsApiService create([ChopperClient? client]) =>
      _$NewsApiService(client);
}
