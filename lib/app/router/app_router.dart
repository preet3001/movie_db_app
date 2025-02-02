import 'package:flutter/material.dart';
import 'package:movie_db_app/bootstrap.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_bloc.dart';
import 'package:movie_db_app/dashboard/bloc/movie_listing_bloc/movie_listing_event.dart';
import 'package:movie_db_app/dashboard/view/dashboard_page.dart';
import 'package:movie_db_app/detail/view/movie_detail.dart';
import 'package:movie_db_app/login/view/login_page.dart';
import 'package:movie_db_app/network/api_client/api_client.dart' as client;
import 'package:movie_db_app/network/models/movie_listing_model.dart';
import 'package:movie_db_app/network/repositories/movie_repository.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case DashboardPage.route:
        return MaterialPageRoute(
          builder: (_) => DashboardPage(
            movieListingBloc: MovieListingBloc(
              MovieRepository(
                apiClient: getIt<client.ApiClient>(),
              ),
            )..add(FetchMovies()),
          ),
        );
      case MovieDetail.route:
        final movieListingItemModel =
            settings.arguments! as MovieListingItemModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MovieDetail(
            itemModel: movieListingItemModel,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Data Found'),
            ),
          ),
        );
    }
  }
}
