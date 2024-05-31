import 'package:films_app/features/latest_films/widgets/widgets.dart';
import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';

class LatestFilmsScreen extends StatefulWidget {
  final void Function(FilmModel film)? updateFavorites;
  final List<FilmModel> latestFilms;

  const LatestFilmsScreen({
    super.key,
    required this.latestFilms,
    required this.updateFavorites,
  });

  @override
  State<LatestFilmsScreen> createState() => _LatestFilmsScreenState();
}

class _LatestFilmsScreenState extends State<LatestFilmsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderSection(onBackTap: () => Navigator.of(context).pop()),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.latestFilms.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 381,
                ),
                itemBuilder: (context, index) {
                  return FilmItem(
                    film: widget.latestFilms[index],
                    updateFavorites: widget.updateFavorites,
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
