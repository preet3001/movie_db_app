import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_bloc.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_event.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_state.dart';
import 'package:movie_db_app/dashboard/view/widget/movie_item.dart';
import 'package:movie_db_app/dashboard/view/widget/search_delegate.dart';
import 'package:movie_db_app/l10n/l10n.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({required this.movieListingBloc, super.key});
  static const String route = 'dashboard';
  final MovieListingBloc movieListingBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => movieListingBloc,
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.dashboardAppbarTitle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<MovieListingBloc>().add(
              FetchMovies(),
            ),
        child: BlocConsumer<MovieListingBloc, MovieListingState>(
          listener: (context, state) {},
          builder: (context, state) {
            return switch (state) {
              MovieListingCompletedState() => ListView.separated(
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
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            };
          },
        ),
      ),
    );
  }
}
