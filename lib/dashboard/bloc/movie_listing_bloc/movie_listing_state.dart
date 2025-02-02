import 'package:equatable/equatable.dart';
import 'package:movie_db_app/network/models/movie_listing_model.dart';

sealed class MovieListingState extends Equatable {
  const MovieListingState();

  @override
  List<Object?> get props => [];
}

class MovieListingInitialState extends MovieListingState {}

class MovieListingLoadingState extends MovieListingState {}

class MovieListingCompletedState extends MovieListingState {
  const MovieListingCompletedState(this.movies);
  final List<MovieListingItemModel> movies;

  @override
  List<Object?> get props => [movies];
}

class MovieListingFailiure extends MovieListingState {}
