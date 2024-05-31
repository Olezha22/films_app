import 'package:dio/dio.dart';
import 'package:films_app/models/film_model.dart';
import 'package:films_app/repositories/film/abstract_film_repository.dart';
class FilmRepository implements AbstractFilmRepository {
  final Dio dio;
  final String apiKey = 'f6f49ae65713a7db7eefa69090187757';
  final String topRatedUrl = 'https://api.themoviedb.org/3/movie/top_rated';
  final String latestUrl = 'https://api.themoviedb.org/3/movie/now_playing';

  FilmRepository({required this.dio});

  @override
  Future<List<FilmModel>> fetchTopRatedMovies() async {
    try {
      final response = await dio.get(
        topRatedUrl,
        queryParameters: {
          'api_key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List movies = data['results'];
        return movies.map((movie) => FilmModel.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load top rated movies');
      }
    } catch (e) {
      throw Exception('Failed to load top rated movies: $e');
    }
  }

  @override
  Future<List<FilmModel>> fetchLatestMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        latestUrl,
        queryParameters: {
          'api_key': apiKey,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List movies = data['results'];
        return movies.map((movie) => FilmModel.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load latest movies');
      }
    } catch (e) {
      throw Exception('Failed to load latest movies: $e');
    }
  }
}
