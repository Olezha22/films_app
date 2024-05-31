import 'package:films_app/features/favorite/view/favorite_screen.dart';
import 'package:films_app/features/favorite/widgets/film_details.dart';
import 'package:films_app/features/favorite/widgets/film_image.dart';
import 'package:films_app/repositories/hive/hive_film_model.dart';
import 'package:flutter/material.dart';

class FavoriteFilmItem extends StatelessWidget {
  final HiveFilmModel film;
  final VoidCallback onDelete;

  const FavoriteFilmItem({
    super.key,
    required this.film,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String description = film.description;
    if (description.length > 100) {
      description = '${description.substring(0, 100)}...';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilmImage(imageUrl: film.image, onDelete: onDelete),
            SizedBox(
              width: MediaQuery.of(context).size.width - 212,
              child: FilmDetails(
                title: film.title,
                rate: film.rate,
                genres: film.genres,
                description: description,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
