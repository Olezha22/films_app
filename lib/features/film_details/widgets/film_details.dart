import 'package:films_app/features/film_details/widgets/widgets.dart';
import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmDetails extends StatelessWidget {
  final FilmModel film;
  final bool isFull;
  final VoidCallback onReadMoreTap;

  const FilmDetails({
    super.key,
    required this.film,
    required this.isFull,
    required this.onReadMoreTap,
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
        RatingRow(rate: film.rate),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            film.genres,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            isFull ? film.description : description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFF888888),
            ),
          ),
        ),
        if (isFull)
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              film.date,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: onReadMoreTap,
            child: Text(
              isFull ? 'Read Less' : 'Read More',
              style: const TextStyle(
                color: Color(0xFFFFC700),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
