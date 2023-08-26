import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

import '../providers.dart';

//*PROVIDERS CASOS DE USO:

//* 1 Llama el endpoint nowPlayingmovies de the movie db
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlaying;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);

//* 2 Llama el endpoint popular movies de the movie db
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getPopular;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);

//* 3 Llama el endpoint upcomming movies de the movie db
final upCoomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getUpCooming;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);

//* 4 Llama el endpoint top rated movies de the movie db
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getTopRated;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);



typedef MovieCallback = Future<List<Movie>> Function({int page});

//! CLASE QUE CONTROLA LOS ESTADOS HAY UNO POR CADA OBJETO QUE CREE UN ENDPOINT:

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isLoading = false;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
