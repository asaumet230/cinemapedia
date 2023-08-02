import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../providers.dart';

/*
  {
    '45678':Movie(),
    '45679':Movie(),
    '45677':Movie(),
    '45676':Movie(),
  }
 */

//? CASOS DE USO:

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovieInfo = ref.watch(moviesRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: getMovieInfo);
});

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
