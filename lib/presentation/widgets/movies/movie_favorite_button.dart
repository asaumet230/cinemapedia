import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class MovieFavoriteButton extends ConsumerWidget {
  final Movie movie;

  const MovieFavoriteButton({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteMovie = ref.watch(isFavoriteProvider(movie.id));
    return IconButton(
      onPressed: () async {
        await ref.read(favoritesMoviesProvider.notifier).toggleFavorite(movie);
        // ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
        ref.invalidate(isFavoriteProvider(movie.id));
      },
      icon: isFavoriteMovie.when(
        data: (isFavorite) {
          return isFavorite
              ? const Icon(Icons.favorite_rounded, color: Colors.red)
              : const Icon(Icons.favorite_border);
        },
        error: (_, __) => throw UnimplementedError(),
        loading: () => const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
