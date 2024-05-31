import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:films_app/repositories/hive/hive_film_model.dart';
import 'package:films_app/repositories/hive/hive_repository.dart';
import 'package:films_app/repositories/search_film/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:films_app/models/film_model.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchFilmEvent>(_onSearch, transformer: debounceDroppable(const Duration(milliseconds: 100)));
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onSearch(SearchFilmEvent event, Emitter<SearchState> emit) async {
    if (event.query.length < 3) {
      emit(SearchLoaded(films: const []));
      return;
    }

    emit(SearchLoading());

    try {
      final films = await GetIt.I<SearchRepository>().searchFilms(event.query);
      emit(SearchLoaded(films: films));
    } catch (e) {
      emit(SearchFailure(exception: e));
    }
  }

  Future<void> _onAddFavorite(AddFavoriteEvent event, Emitter<SearchState> emit) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      final updatedFilms = currentState.films.map((film) {
        if (film.title == event.film.title) {
          final updatedFilm = film.copyWith(isFavorite: true);
          HiveRepository.addFilm(HiveFilmModel.fromFilmModel(updatedFilm));
          return updatedFilm;
        }
        return film;
      }).toList();

      emit(SearchLoaded(films: updatedFilms));
    }
  }

  Future<void> _onRemoveFavorite(RemoveFavoriteEvent event, Emitter<SearchState> emit) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      final updatedFilms = currentState.films.map((film) {
        if (film.title == event.film.title) {
          final updatedFilm = film.copyWith(isFavorite: false);
          HiveRepository.deleteFilm(updatedFilm.title);
          return updatedFilm;
        }
        return film;
      }).toList();

      emit(SearchLoaded(films: updatedFilms));
    }
  }
}
