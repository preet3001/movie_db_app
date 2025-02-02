import 'package:flutter/material.dart';
import 'package:movie_db_app/l10n/l10n.dart';
import 'package:movie_db_app/network/models/movie_listing_model.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({required this.itemModel, super.key});
  final MovieListingItemModel itemModel;
  static const route = 'detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(itemModel.title ?? ''),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://image.tmdb.org/t/p/w200/${itemModel.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    context.l10n.detailOverView,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    itemModel.overview ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    '${context.l10n.lang} ${itemModel.originalLanguage?.name}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SliverFillRemaining(),
        ],
      ),
    );
  }
}
