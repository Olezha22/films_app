import 'package:dio/dio.dart';
import 'package:films_app/models/film_model.dart';
import 'package:films_app/repositories/search_film/abstract_search_repository.dart';

class SearchRepository implements AbstractSearchRepository{
  final Dio dio;
  final String baseUrl = 'https://api.themoviedb.org/3/search/movie';
  final String _apiKey = 'f6f49ae65713a7db7eefa69090187757';

  SearchRepository({required this.dio});

  @override
  Future<List<FilmModel>> searchFilms(String query) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          'query': query,
          'language': 'en-US',
          'api_key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List movies = data['results'];
        return movies.map((movie) => FilmModel.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load films');
      }
    } catch (e) {
      throw Exception('Failed to load films: $e');
    }
  }
}
