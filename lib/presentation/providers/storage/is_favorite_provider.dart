import 'package:flutter_riverpod/flutter_riverpod.dart';

import './local_storage_repository_provider.dart';

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageProvider = ref.watch(localStorageRepositoryProvider);

  return localStorageProvider.isMovieFavorite(movieId);
});
