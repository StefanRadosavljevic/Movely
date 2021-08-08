import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:moviesapp/models/app_config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final String backdropPath;
  final num rating;
  final String releaseDate;

  Movie({
    this.name,
    this.language,
    this.isAdult,
    this.description,
    this.posterPath,
    this.backdropPath,
    this.rating,
    this.releaseDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'language': language,
      'isAdult': isAdult,
      'description': description,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'rating': rating,
      'releaseDate': releaseDate,
    };
  }

  String posterURL() {
    // get app config class
    final AppConfig _appConfig = GetIt.instance.get<AppConfig>();
    return '${_appConfig.BASE_IMAGE_API_URL}${this.posterPath}';
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      name: map['name'],
      language: map['language'],
      isAdult: map['isAdult'],
      description: map['description'],
      posterPath: map['posterPath'],
      backdropPath: map['backdropPath'],
      rating: map['rating'],
      releaseDate: map['releaseDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
