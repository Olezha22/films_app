import 'package:films_app/repositories/genre/abstract_gender_repository.dart';

class GenreRepository implements AbstractGenreRepository {
  final Map<int, String> genres = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
  };

  @override
  String getGenreNames(List<int> genreIds) {
    List<String> genderList =
        genreIds.map((id) => genres[id] ?? 'Unknown Genre').toList();
    String genresToString = "";
    for (var i = 0; i < genderList.length; i++) {
      if (i != genderList.length - 1) {
        genresToString += "${genderList[i]}, ";
      } else {
        genresToString += genderList[i];
      }
    }
    return genresToString;
  }

}
