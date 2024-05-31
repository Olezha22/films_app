part of 'search_bloc.dart';


abstract class SearchState extends Equatable {
}

class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final List<FilmModel> films;

  SearchLoaded({required this.films});

  @override
  List<Object?> get props => [films];
}

class SearchFailure extends SearchState {
  final Object? exception;

  SearchFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

