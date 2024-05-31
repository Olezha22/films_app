import 'package:films_app/features/film_details/film_details.dart';
import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmItem extends StatelessWidget {
  final FilmModel film;
  final void Function(FilmModel film)? updateFavorites;

  const FilmItem({
    Key? key,
    required this.film,
    required this.updateFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FilmDetailsScreen(
                      film: film,
                      updateFavorites: updateFavorites,
                    ),
                    transitionDuration: const Duration(milliseconds: 1000),
                    transitionsBuilder: (context, animation,
                        secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      final tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve),
                      );

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(film.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.white,
                ),
                width: 182,
                height: 273,
                margin: const EdgeInsets.all(15.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: GestureDetector(
                    onTap: () {
                      if (updateFavorites != null) {
                        updateFavorites!(film);
                      }
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
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  film.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Text(
                "${film.rate}  ",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Image(image: AssetImage("assets/star.png")),
            ],
          ),
        ),
      ],
    );
  }
}
