import 'package:equatable/equatable.dart';
import 'package:films_app/repositories/genre/genre_repository.dart';
import 'package:films_app/repositories/hive/hive_repository.dart';

class FilmModel extends Equatable {
  final String title;
  final String description;
  final String date;
  final String image;
  final double rate;
  final String genres;
  final bool isFavorite;

   FilmModel({
    required this.title,
    required this.image,
    required this.rate,
    required this.date,
    required this.description,
    required this.genres,
    bool? isFavorite,
  }) : isFavorite = isFavorite ?? HiveRepository.isFilmFavorite(title);

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    List<int> genreIds = List<int>.from(json['genre_ids']);
    final genreRepository = GenreRepository();
    String genreNames = genreRepository.getGenreNames(genreIds);

    String imagePath =
        "https://image.tmdb.org/t/p/w500${json['backdrop_path']}";

    if (json['backdrop_path'] == null || json['backdrop_path'] == '') {
      if (json['poster_path'] == null || json['poster_path'] == '') {
        imagePath =
            "https://eagle-sensors.com/wp-content/uploads/unavailable-image.jpg";
      } else {
        imagePath = "https://image.tmdb.org/t/p/w500${json['poster_path']}";
      }
    }

    return FilmModel(
      title: json['title'],
      image: imagePath,
      rate: ((json['vote_average'].toDouble() / 2) * 2).round() / 2.0,
      date: json['release_date'].toString(),
      description: json['overview'],
      genres: genreNames,
    );
  }

  FilmModel copyWith({bool? isFavorite}) {
    return FilmModel(
      title: title,
      image: image,
      rate: rate,
      date: date,
      description: description,
      genres: genres,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [title, image, rate, date, description, genres, isFavorite];
}
