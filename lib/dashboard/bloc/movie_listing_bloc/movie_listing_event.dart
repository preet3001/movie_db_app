import 'package:equatable/equatable.dart';

sealed class MovieListingEvent extends Equatable {
  const MovieListingEvent();
  @override
  List<Object?> get props => [];
}

class FetchMovies extends MovieListingEvent {}

class SearchMovie extends MovieListingEvent {
  const SearchMovie(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}
