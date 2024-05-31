// ignore_for_file: must_be_immutable
import 'package:films_app/features/film_details/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:films_app/models/film_model.dart';

class FilmDetailsScreen extends StatefulWidget {
  FilmModel film;
  final void Function(FilmModel film)? updateFavorites;

  FilmDetailsScreen({
    super.key,
    required this.film,
    this.updateFavorites,
  });

  @override
  State<FilmDetailsScreen> createState() => _FilmDetailsScreenState();
}

class _FilmDetailsScreenState extends State<FilmDetailsScreen> {
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FilmImageHeader(
            film: widget.film,
            onBackTap: () => Navigator.of(context).pop(),
            onFavoriteTap: () {
              if (widget.updateFavorites != null) {
                setState(() {
                  widget.updateFavorites!(widget.film);
                  widget.film =
                      widget.film.copyWith(isFavorite: !widget.film.isFavorite);
                });
              }
            },
          ),
          FilmDetails(
            film: widget.film,
            isFull: isFull,
            onReadMoreTap: () {
              setState(() {
                isFull = !isFull;
              });
            },
          ),
        ],
      ),
    );
  }
}
