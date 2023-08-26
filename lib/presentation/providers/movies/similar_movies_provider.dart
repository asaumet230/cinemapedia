import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

final similarMoviesProvider = FutureProvider.family((ref, int movieId) {
  final similarMovies =
      ref.watch(moviesRepositoryProvider).getSimilarMovies(movieId);
  return similarMovies;
});
