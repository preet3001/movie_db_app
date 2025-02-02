import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_event.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_state.dart';
import 'package:movie_db_app/network/models/movie_listing_model.dart';
import 'package:movie_db_app/network/repositories/movie_repository.dart';

class MovieListingBloc extends Bloc<MovieListingEvent, MovieListingState> {
  MovieListingBloc(this.repository) : super(MovieListingInitialState()) {
    on<FetchMovies>(_fetchMovies);
    on<SearchMovie>(_onSearchMovies);
  }
  final MovieRepository repository;
  List<MovieListingItemModel> movies = [];

  Future<void> _fetchMovies(
    MovieListingEvent event,
    Emitter<MovieListingState> emit,
  ) async {
    emit(MovieListingLoadingState());
    try {
      final data = await repository.getListing();
      movies.addAll(data.results ?? <MovieListingItemModel>[]);
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
    }
    emit(MovieListingCompletedState(movies));
  }

  void _onSearchMovies(SearchMovie event, Emitter<MovieListingState> emit) {
    if (event.query.isEmpty) {
      emit(MovieListingCompletedState(movies));
    } else {
      final filteredMovies = movies
          .where(
            (movie) =>
                movie.title?.toLowerCase().contains(
                      event.query.toLowerCase(),
                    ) ??
                false,
          )
          .toList();
      emit(MovieListingCompletedState(filteredMovies));
    }
  }
}
