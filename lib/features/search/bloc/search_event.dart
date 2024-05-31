part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {}

class SearchFilmEvent extends SearchEvent {
  final String query;
  

  SearchFilmEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class AddFavoriteEvent extends SearchEvent {
  final FilmModel film;

  AddFavoriteEvent(this.film);

  @override
  List<Object?> get props => [film];
}

class RemoveFavoriteEvent extends SearchEvent {
  final FilmModel film;

  RemoveFavoriteEvent(this.film);

  @override
  List<Object?> get props => [film];
}


