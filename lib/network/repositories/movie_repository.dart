import 'package:dio/dio.dart';
import 'package:movie_db_app/network/api_client/api_client.dart' as client;
import 'package:movie_db_app/network/models/movie_listing_model.dart';

class MovieRepository {
  const MovieRepository({required this.apiClient});
  final client.ApiClient apiClient;

  Future<MovieListingModel> getListing() async {
    // ignore: omit_local_variable_types
    final Response<Map<String, dynamic>> response =
        await apiClient.dio.get('discover/movie');
    if (response.statusCode == 200) {
      return MovieListingModel.fromJson(response.data!);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
