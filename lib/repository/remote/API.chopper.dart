// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'API.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$NewsApiService extends NewsApiService {
  _$NewsApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsApiService;

  @override
  Future<Response<dynamic>> getArticles(String sources) {
    final Uri $url =
        Uri.parse('/v2/top-headlines?apiKey=a7d93afad0b0494a9e10e5dbcd6f939c');
    final Map<String, dynamic> $params = <String, dynamic>{'category': sources};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
