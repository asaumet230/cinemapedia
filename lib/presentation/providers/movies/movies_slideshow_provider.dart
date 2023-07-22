import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  return nowPlayingMovies.isEmpty ? [] : nowPlayingMovies.sublist(0, 6);
});
