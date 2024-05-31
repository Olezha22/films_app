part of 'film_info_bloc.dart';

abstract class FilmInfoState extends Equatable {}

class FilmInfoInitial extends FilmInfoState {
  @override
  List<Object?> get props => [];
}

class FilmInfoLoading extends FilmInfoState {
  @override
  List<Object?> get props => [];
}

class FilmInfoLoaded extends FilmInfoState {
  FilmInfoLoaded({
    required this.topRatedFilms,
    required this.latestFilms,
    this.hasReachedMax = false,
  });

  final List<FilmModel> topRatedFilms;
  final List<FilmModel> latestFilms;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [topRatedFilms, latestFilms, hasReachedMax];
}

class FilmInfoLoadingFailure extends FilmInfoState {
  FilmInfoLoadingFailure({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
