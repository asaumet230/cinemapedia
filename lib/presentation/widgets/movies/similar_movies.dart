import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));
    final textStyle = Theme.of(context).textTheme;

    return similarMoviesFuture.when(
      data: (movies) => _Recomendations(movies: movies),
      error: (_, __) => Center(
          child: Text(
        'No se pudo cargar películas similares',
        style: textStyle.titleMedium,
      )),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MoviesHorizontalListView(
        title: 'Recomendaciones:',
        movies: movies,
      ),
    );
  }
}
