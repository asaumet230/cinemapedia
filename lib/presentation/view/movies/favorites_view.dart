import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  static const name = 'favorites';

  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies =
        await ref.read(favoritesMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoritesMoviesProvider).values.toList();

    if (favoritesMovies.isEmpty) {
      final color = Theme.of(context).colorScheme;

      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_outline_rounded,
                color: color.primary,
                size: 70,
              ),
              Text(
                'Oh No!',
                style: TextStyle(color: color.primary, fontSize: 30),
              ),
              const Text(
                'Agrega a favoritos para que se muestren',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: () => context.go('/home/0'),
                child: const Text('Agrega a Favoritos'),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoritesMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
