import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:films_app/models/film_model.dart';
import 'package:films_app/repositories/film/film_repository.dart';
import 'package:films_app/repositories/hive/hive_film_model.dart';
import 'package:films_app/repositories/hive/hive_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'film_info_event.dart';
part 'film_info_state.dart';
class FilmInfoBloc extends Bloc<FilmInfoEvent, FilmInfoState> {
  FilmInfoBloc() : super(FilmInfoInitial()) {
    on<LoadFilmInfo>((event, emit) async {
      try {
        if (state is! FilmInfoLoaded) {
          emit(FilmInfoLoading());
        }

        final topRated = await GetIt.I<FilmRepository>().fetchTopRatedMovies();
        final latest = await GetIt.I<FilmRepository>().fetchLatestMovies(page: 1);
        emit(FilmInfoLoaded(
          topRatedFilms: topRated,
          latestFilms: latest,
        ));
      } catch (e) {
        emit(FilmInfoLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<AddFavoriteEvent>((event, emit) async {
      if (state is FilmInfoLoaded) {
        final currentState = state as FilmInfoLoaded;

        // Update the in-memory state
        final updatedTopRatedFilms = currentState.topRatedFilms.map((film) {
          if (film.title == event.film.title) {
            final updatedFilm = film.copyWith(isFavorite: true);
            HiveRepository.addFilm(HiveFilmModel.fromFilmModel(updatedFilm));
            return updatedFilm;
          }
          return film;
        }).toList();

        final updatedLatestFilms = currentState.latestFilms.map((film) {
          if (film.title == event.film.title) {
            final updatedFilm = film.copyWith(isFavorite: true);
            HiveRepository.addFilm(HiveFilmModel.fromFilmModel(updatedFilm));
            return updatedFilm;
          }
          return film;
        }).toList();

        emit(FilmInfoLoaded(
          topRatedFilms: updatedTopRatedFilms,
          latestFilms: updatedLatestFilms,
        ));
      }
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      if (state is FilmInfoLoaded) {
        final currentState = state as FilmInfoLoaded;

        final updatedTopRatedFilms = currentState.topRatedFilms.map((film) {
          if (film.title == event.film.title) {
            final updatedFilm = film.copyWith(isFavorite: false);
            HiveRepository.deleteFilm(updatedFilm.title);
            return updatedFilm;
          }
          return film;
        }).toList();

        final updatedLatestFilms = currentState.latestFilms.map((film) {
          if (film.title == event.film.title) {
            final updatedFilm = film.copyWith(isFavorite: false);
            HiveRepository.deleteFilm(updatedFilm.title);
            return updatedFilm;
          }
          return film;
        }).toList();

        emit(FilmInfoLoaded(
          topRatedFilms: updatedTopRatedFilms,
          latestFilms: updatedLatestFilms,
        ));
      }
    });

    on<LoadMoreLatestFilms>((event, emit) async {
      if (state is FilmInfoLoaded) {
        final currentState = state as FilmInfoLoaded;
        try {
          final latest = await GetIt.I<FilmRepository>().fetchLatestMovies(page: event.page);
          if (latest.isEmpty) {
            emit(FilmInfoLoaded(hasReachedMax: true, topRatedFilms: currentState.topRatedFilms,latestFilms: currentState.latestFilms));
          } else {
            emit(FilmInfoLoaded(
              topRatedFilms: currentState.topRatedFilms,
              latestFilms: List.of(currentState.latestFilms)..addAll(latest),
              hasReachedMax: false,
            ));
          }
        } catch (e) {
          emit(FilmInfoLoadingFailure(exception: e));
        }
      }
    });
  }
}
