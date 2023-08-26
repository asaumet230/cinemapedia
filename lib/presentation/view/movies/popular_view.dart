import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../providers/providers.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: popularMovies,
        loadNextPage: () =>
            ref.read(popularMoviesProvider.notifier).loadNextPage(),
        subtitle: HumanFormats.shortDate(DateTime.now()),
        title: 'Populares',
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
