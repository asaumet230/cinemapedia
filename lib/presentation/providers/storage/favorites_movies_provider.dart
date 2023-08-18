import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/local_storage_repository.dart';
import 'local_storage_repository_provider.dart';

import '../../../domain/entities/movie.dart';

final favoritesMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
  {
   12345: Movie,
   12346: Movie, 
   12347: Movie, 
   12348: Movie, 
  }
*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  LocalStorageRepository localStorageRepository; //Domain
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
  }
}
