import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:podfy/data/models/podcast.dart';
import 'package:http/http.dart' as http;

class PodcastService extends ChangeNotifier{
  final String baseUrl;
  Podcast? _podcastAtual;
  List<Podcast>? _podcasts;

  PodcastService(this.baseUrl);

  Podcast? get podcastAtual => _podcastAtual;
  set podcastAtual(Podcast? p) {
    _podcastAtual = p;
    notifyListeners();
  }

  List<Podcast>? get podcasts => _podcasts;
  set podcasts(List<Podcast>? p) {
    _podcasts = p;
    notifyListeners();
  }

  Future<List<Podcast>> listarRecentes() async {
    try {
      var url = Uri.parse(baseUrl);
      var res = await http.get(url);
      return (jsonDecode(res.body) as List)
          .map((e) => Podcast.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

   Future<List<Podcast>> listarTodos() async {
    try {
      var url = Uri.parse('$baseUrl/todos');
      var res = await http.get(url);
      return (jsonDecode(res.body) as List)
          .map((e) => Podcast.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  // TODO: Listar os podcasts de um autor
  // TODO: Listar todos os podcasts para a aba de pesqquisar
}
