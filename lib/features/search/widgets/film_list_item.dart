import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmListItem extends StatelessWidget {
  final FilmModel film;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const FilmListItem({
    super.key,
    required this.film,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    String description = film.description;
    if (description.length > 100) {
      description = '${description.substring(0, 100)}...';
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(film.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                    ),
                    width: 182,
                    height: 273,
                    margin: const EdgeInsets.all(15.0),
                  ),
                  GestureDetector(
                    onTap: onFavoriteTap,
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Image(
                        image: AssetImage(film.isFavorite
                            ? "assets/sel_favorite.png"
                            : "assets/favorite.png"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 212,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15.0),
                    Text(
                      film.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "${film.rate}  ",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
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
                          const Image(
                              image: AssetImage("assets/empty_star.png")),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      film.genres,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
