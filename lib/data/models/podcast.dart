import 'package:flutter/material.dart';

class Podcast {
  final String titulo;
  final String subtitulo;
  final String autor;
  final int duracao;
  final String link;
  final String imagem;

  Podcast(this.titulo, this.subtitulo, this.autor, this.duracao, this.link, this.imagem);

  static Podcast fromJson(Map json) {
    return Podcast(json['title'] as String, json['subtitle'] as String,
        json['author'] as String, json['duration'] as int, json['link'], json['image']);
  }
}
