class Author {
  String name;
  String description;
  int id;

  Author(this.name, this.description, this.id);
  

  static Author fromJson(Map json) {
    return Author (json['name'] as String, json['description'] as String, json['id'] as int);
  }
}
