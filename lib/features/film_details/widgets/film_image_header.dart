

import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmImageHeader extends StatelessWidget {
  final FilmModel film;
  final VoidCallback onBackTap;
  final VoidCallback onFavoriteTap;

  const FilmImageHeader({
    super.key,
    required this.film,
    required this.onBackTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(film.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.7, 1],
            ),
          ),
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBackTap,
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image(image: AssetImage("assets/back_white.png")),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage(
                        film.isFavorite
                            ? "assets/sel_favorite.png"
                            : "assets/favorite.png",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 300),
          child: Text(
            film.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
