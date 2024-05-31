import 'package:films_app/repositories/hive/hive_film_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveRepository {
  static initHive() async {
    final applicationDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();

    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(HiveFilmModelAdapter());

    Hive.openBox<HiveFilmModel>('film');
  }

  static void addFilm(HiveFilmModel filmModel) {
    Hive.box<HiveFilmModel>('film').add(filmModel);
  }

  static List<HiveFilmModel> getAllFilms() {
    final result = Hive.box<HiveFilmModel>('film').values.toList();
    return result;
  }

   static void deleteFilm(String title) {
    final box = Hive.box<HiveFilmModel>('film');
    final filmKey = box.keys.firstWhere(
      (key) {
        final film = box.get(key) as HiveFilmModel;
        return film.title == title;
      },
      orElse: () => null,
    );
    if (filmKey != null) {
      box.delete(filmKey);
    }

  }

  static bool isFilmFavorite(String title) {
    final box = Hive.box<HiveFilmModel>('film');
    return box.values.any((film) => film.title == title);
  }
}
