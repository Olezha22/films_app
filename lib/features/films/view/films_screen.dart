import 'dart:async';

import 'package:films_app/features/film_details/film_details.dart';
import 'package:films_app/features/films/bloc/film_info_bloc.dart';
import 'package:films_app/features/films/widgets/widgets.dart';
import 'package:films_app/features/latest_films/latest_films.dart';
import 'package:films_app/features/latest_films/widgets/text_widget.dart';
import 'package:films_app/models/film_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmsScreen extends StatefulWidget {
  const FilmsScreen({super.key});

  @override
  State<FilmsScreen> createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  final _filmInfoBloc = FilmInfoBloc();
  final _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    _filmInfoBloc.add(LoadFilmInfo());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200 && !_isLoadingMore) {
      _isLoadingMore = true;
      _currentPage++;
      _filmInfoBloc.add(LoadMoreLatestFilms(page: _currentPage));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _filmInfoBloc.close();
    super.dispose();
  }

  void _updateFavorites(FilmModel film) {
    if (film.isFavorite) {
      _filmInfoBloc.add(RemoveFavoriteEvent(film: film));
    } else {
      _filmInfoBloc.add(AddFavoriteEvent(film: film));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FilmInfoBloc, FilmInfoState>(
        bloc: _filmInfoBloc,
        builder: (context, state) {
          if (state is FilmInfoLoaded) {
            final topRatedList = state.topRatedFilms;
            final latestList = state.latestFilms;
            final hasReachedMax = state.hasReachedMax;

            return RefreshIndicator(
              onRefresh: () async {
                final completer = Completer<void>();
                _filmInfoBloc.add(LoadFilmInfo(completer: completer));
                return completer.future;
              },
              color: const Color(0xFFFFC700),
              child: SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: "Top Five",
                      ),
                      SizedBox(
                        height: 315,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return TopRatedFilmItem(
                              film: topRatedList[index],
                              onUpdateFavorites: _updateFavorites,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FilmDetailsScreen(
                                      film: topRatedList[index],
                                      updateFavorites: _updateFavorites,
                                    ),
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.ease;

                                      final tween =
                                          Tween(begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            text: "Latest",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        LatestFilmsScreen(
                                      latestFilms: latestList,
                                      updateFavorites: _updateFavorites,
                                    ),
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0, -1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeIn;

                                      final tween =
                                          Tween(begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                "SEE MORE",
                                style: TextStyle(
                                  color: Color(0xFFFFC700),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: latestList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == latestList.length) {
                            return hasReachedMax
                                ? const SizedBox.shrink()
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          }
                          final latestFilm = latestList[index];
                          String description = latestFilm.description;
                          if (description.length > 100) {
                            description = '${description.substring(0, 100)}...';
                          }
                          return LatestFilmItem(
                            film: latestFilm,
                            onUpdateFavorites: _updateFavorites,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      FilmDetailsScreen(
                                    film: latestFilm,
                                    updateFavorites: _updateFavorites,
                                  ),
                                  transitionDuration:
                                      const Duration(milliseconds: 1000),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    final tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is FilmInfoLoadingFailure) {
            return NoConnection(filmInfoBloc: _filmInfoBloc);
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
