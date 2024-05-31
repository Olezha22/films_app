import 'package:films_app/features/favorite/widgets/widgets.dart';
import 'package:films_app/repositories/hive/hive_film_model.dart';
import 'package:films_app/repositories/hive/hive_repository.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<HiveFilmModel> listFavFilms = [];

  @override
  void initState() {
    listFavFilms = HiveRepository.getAllFilms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextWidget(
                text: "Favorite",
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listFavFilms.length,
                itemBuilder: (context, index) {
                  return FavoriteFilmItem(
                    film: listFavFilms[index],
                    onDelete: () {
                      HiveRepository.deleteFilm(listFavFilms[index].title);
                      setState(() {
                        listFavFilms = HiveRepository.getAllFilms();
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
