import 'package:films_app/models/film_model.dart';
import 'package:hive/hive.dart';

part 'hive_film_model.g.dart';

@HiveType(typeId: 0)
class HiveFilmModel {
  HiveFilmModel({
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.rate,
    required this.genres,
    required this.isFavorite,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String date;

  @HiveField(3)
  String image;

  @HiveField(4)
  double rate;

  @HiveField(5)
  String genres;

  @HiveField(6)
  bool isFavorite;

  factory HiveFilmModel.fromFilmModel(FilmModel film) {
    return HiveFilmModel(
      title: film.title,
      description: film.description,
      date: film.date,
      image: film.image,
      rate: film.rate,
      genres: film.genres,
      isFavorite: true,
    );
  }
}
