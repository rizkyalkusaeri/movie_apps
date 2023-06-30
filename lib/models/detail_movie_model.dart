import 'package:movie_apps/models/genre_model.dart';

class DetailMovie {
  int id;
  bool adult;
  String backdropPath;
  List<Genre> genres;
  String originalLanguage;
  String originalTitle;
  String overview;
  String runtime;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  String homepage;
  String status;
  String voteAverage;
  bool video;
  String? numberOfEpisode;

  DetailMovie({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.runtime,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.homepage,
    required this.voteAverage,
    required this.status,
    this.numberOfEpisode,
  });

  factory DetailMovie.fromJson(Map<String, dynamic> json) {
    return DetailMovie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'] ?? '',
      genres: Genre.fromJsonList(json['genres']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'] ?? json['original_name'],
      overview: json['overview'] ?? 'No Overview yet',
      runtime: json['runtime'].toString(),
      popularity: json['popularity'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? json['first_air_date'],
      title: json['title'] ?? json['name'],
      video: json['video'] ?? false,
      homepage: json['homepage'] ?? '-',
      voteAverage: json['vote_average'].toString(),
      status: json['status'],
      numberOfEpisode: json['status'],
    );
  }
}
