//ignore_for_file: argument_type_not_assignable
//ignore_for_file: inference_failure_on_untyped_parameter
//ignore_for_file: avoid_dynamic_calls
//ignore_for_file: inference_failure_on_collection_literal
// ignore_for_file: constant_identifier_names

class MovieListingModel {
  MovieListingModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieListingModel.fromJson(Map<String, dynamic> json) =>
      MovieListingModel(
        page: json['page'],
        results: json['results'] == null
            ? []
            : List<MovieListingItemModel>.from(
                json['results']!.map((x) => MovieListingItemModel.fromJson(x)),
              ),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
  final int? page;
  final List<MovieListingItemModel>? results;
  final int? totalPages;
  final int? totalResults;

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}

class MovieListingItemModel {
  const MovieListingItemModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieListingItemModel.fromJson(Map<String, dynamic> json) =>
      MovieListingItemModel(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'] == null
            ? []
            : List<int>.from(json['genre_ids']!.map((x) => x)),
        id: json['id'],
        originalLanguage: originalLanguageValues.map[json['original_language']],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity']?.toDouble(),
        posterPath: json['poster_path'],
        releaseDate: json['release_date'] == null
            ? null
            : DateTime.parse(json['release_date']),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average']?.toDouble(),
        voteCount: json['vote_count'],
      );
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final OriginalLanguage? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'genre_ids':
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        'id': id,
        'original_language': originalLanguageValues.reverse[originalLanguage],
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        //ignore_for_file: lines_longer_than_80_chars
        'release_date':
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}

enum OriginalLanguage { EN, FR, NO, TE }

final originalLanguageValues = EnumValues({
  'en': OriginalLanguage.EN,
  'fr': OriginalLanguage.FR,
  'no': OriginalLanguage.NO,
  'te': OriginalLanguage.TE,
});

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
