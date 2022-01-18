import 'dart:convert';

import 'package:podfy/core/http/http_client.dart';
import 'package:podfy/data/models/podcast.dart';
import 'package:http/http.dart' as http;

class PodcastService implements HttpClient<Podcast> {
  final String baseUrl;

  const PodcastService(this.baseUrl);

  @override
  Future<List<Podcast>> listar() async {
    try {
      var url = Uri.parse(baseUrl);
      var res = await http.get(url);
      return (jsonDecode(res.body) as List)
          .map((e) => Podcast.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('e');
    }
  }
}
