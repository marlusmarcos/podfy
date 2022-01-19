import 'dart:convert';

import 'package:podfy/data/models/podcast.dart';
import 'package:http/http.dart' as http;

class PodcastService {
  final String baseUrl;

  const PodcastService(this.baseUrl);

  Future<List<Podcast>> listarRecentes() async {
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
  // TODO: Listar os podcasts de um autor
  // TODO: Listar todos os podcasts para a aba de pesqquisar
}
