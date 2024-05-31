import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';

class TopRatedFilmItem extends StatelessWidget {
  final FilmModel film;
  final void Function(FilmModel film)? onUpdateFavorites;
  final VoidCallback onTap;

  const TopRatedFilmItem({
    super.key,
    required this.film,
    required this.onUpdateFavorites,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(film.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.white,
                ),
                width: 300,
                height: 200,
                margin: const EdgeInsets.all(15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: GestureDetector(
                onTap: () {
                  onUpdateFavorites!(film);
                },
                child: Image(
                  image: AssetImage(
                    film.isFavorite
                        ? "assets/sel_favorite.png"
                        : "assets/favorite.png",
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            film.title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Text(
                "${film.rate}  ",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              for (int i = 0; i < film.rate.floor(); i++)
                const Row(
                  children: [
                    Image(image: AssetImage("assets/star.png")),
                    SizedBox(width: 4),
                  ],
                ),
              if (film.rate % 1 != 0)
                const Row(
                  children: [
                    Image(image: AssetImage("assets/half_star.png")),
                    SizedBox(width: 4),
                  ],
                ),
              for (int i = 0; i < 5 - film.rate.ceil(); i++)
                const Image(image: AssetImage("assets/empty_star.png")),
            ],
          ),
        ),
      ],
    );
  }
}
