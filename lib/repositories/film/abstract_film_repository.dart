import 'package:films_app/models/film_model.dart';

abstract class AbstractFilmRepository {
  Future<List<FilmModel>> fetchTopRatedMovies();
  Future<List<FilmModel>> fetchLatestMovies();
}
