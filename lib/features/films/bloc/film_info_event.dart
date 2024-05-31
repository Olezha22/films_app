part of 'film_info_bloc.dart';

abstract class FilmInfoEvent extends Equatable {}

class LoadFilmInfo extends FilmInfoEvent {
  LoadFilmInfo({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class AddFavoriteEvent extends FilmInfoEvent {
  final FilmModel film;

  AddFavoriteEvent({required this.film});

  @override
  List<Object?> get props => [film];
}

class RemoveFavoriteEvent extends FilmInfoEvent {
  final FilmModel film;

  RemoveFavoriteEvent({required this.film});

  @override
  List<Object?> get props => [film];
}

class LoadMoreLatestFilms extends FilmInfoEvent {
  final int page;

  LoadMoreLatestFilms({required this.page});

  @override
  List<Object?> get props => [page];
}
