import 'package:podfy/data/models/author.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutorService {
  // TODO: Listar todos os autores
  final String urlBase;
  Author? podcastAtual;

  AutorService(this.urlBase);

  Future<List<Author>> listarAutores() async {
    try {
      var url = Uri.parse(urlBase);
      var res = await http.get(url);
      return (jsonDecode(res.body) as List)
          .map((e) => Author.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('e');
    }
  }
}