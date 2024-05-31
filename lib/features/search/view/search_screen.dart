import 'package:films_app/features/film_details/film_details.dart';
import 'package:films_app/features/search/bloc/search_bloc.dart';
import 'package:films_app/models/film_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../search/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textController = TextEditingController();
  final searchBloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        bloc: searchBloc,
        builder: (context, state) {
          return SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TextWidget(text: "Search"),
                    SearchBarW(
                      controller: textController,
                      onChanged: (value) {
                        searchBloc.add(SearchFilmEvent(value));
                      },
                    ),
                    if (state is SearchLoaded)
                      Text(
                        "Found (${state.films.length}) results",
                        style: const TextStyle(fontSize: 18),
                      ),
                    if (state is SearchFailure) const SearchErrorMessage(),
                    if (state is SearchLoaded)
                      state.films.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.films.length,
                              itemBuilder: (context, index) {
                                final film = state.films[index];
                                return FilmListItem(
                                  film: film,
                                  onTap: () {
                                    navigateToDetails(film);
                                  },
                                  onFavoriteTap: () {
                                    _update(film);
                                  },
                                );
                              },
                            )
                          : const NoResultsMessage(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _update(FilmModel film) {
    if (film.isFavorite) {
      searchBloc.add(RemoveFavoriteEvent(film));
    } else {
      searchBloc.add(AddFavoriteEvent(film));
    }
  }

  void navigateToDetails(film) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FilmDetailsScreen(
          film: film,
          updateFavorites: _update,
        ),
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
