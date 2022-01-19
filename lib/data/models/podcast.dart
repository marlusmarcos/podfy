import 'package:flutter/material.dart';

class Podcast {
  final String titulo;
  final String subtitulo;
  final String autor;
  final String duracao;

  Podcast(this.titulo, this.subtitulo, this.autor, this.duracao);

  static Podcast fromJson(Map json) {
    return Podcast(json['title'] as String, json['subtitle'] as String,
        json['author'] as String, json['duration'] as String);
  }
}
