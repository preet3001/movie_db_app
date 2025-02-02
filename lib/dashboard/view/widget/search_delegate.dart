import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/bootstrap.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_bloc.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_event.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_state.dart';
import 'package:movie_db_app/dashboard/view/widget/movie_item.dart';
import 'package:movie_db_app/network/api_client/api_client.dart' as client;
import 'package:movie_db_app/network/repositories/movie_repository.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final movieListingBloc = MovieListingBloc(
      MovieRepository(
        apiClient: getIt<client.ApiClient>(),
      ),
    )..add(FetchMovies());
    return BlocConsumer<MovieListingBloc, MovieListingState>(
      bloc: movieListingBloc,
      listener: (context, state) {
        if (state is MovieListingCompletedState) {
          movieListingBloc.add(SearchMovie(query));
        }
      },
      builder: (context, state) {
        if (state is MovieListingCompletedState) {
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final item = state.movies[index];
              return MovieItem(
                item: item,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          );
        } else if (state is MovieListingLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(child: Text('No results found'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // No suggestions
  }
}
