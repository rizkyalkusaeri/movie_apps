class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  static List<Genre> fromJsonList(List list) {
    return list.map((e) => Genre.fromJson(e)).toList();
  }

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'], name: json['name']);
  }
}
