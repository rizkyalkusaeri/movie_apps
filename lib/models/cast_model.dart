class CastModel {
  CastModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.character,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final String character;

  static List<CastModel> fromJsonList(List list) {
    return list.map((e) => CastModel.fromJson(e)).toList();
  }

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'] ?? '',
      character: json['character'],
    );
  }
}
