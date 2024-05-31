import 'package:films_app/models/film_model.dart';

abstract class AbstractSearchRepository {
  Future<List<FilmModel>> searchFilms(String query);
}
