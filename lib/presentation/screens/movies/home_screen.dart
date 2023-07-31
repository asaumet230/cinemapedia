import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upCoomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingMovies = ref.watch(initialLoadingProvider);

    if (isLoadingMovies) return const FullScreenLoader();

    //? PORQUE SE HACE EL IF AQUÍ SIMPLE PORQUE TE AHORRAS LA RENDERIZADA DE LOS WIDGETS Y LA OBSERVADA DE LOS DEMAS PROVIDERS

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upCoomingMovies = ref.watch(upCoomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideShow(movies: moviesSlideshow),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En Cines',
                    subTitle: 'Lunes 31',
                    loadNextPage: () => ref
                        .watch(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    subTitle: 'En 2023',
                    loadNextPage: () => ref
                        .watch(popularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: upCoomingMovies,
                    title: 'Proximamente',
                    subTitle: 'Proximos Estrenos',
                    loadNextPage: () => ref
                        .watch(upCoomingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Mejor Valorada',
                    subTitle: 'Por La Academia',
                    loadNextPage: () => ref
                        .watch(topRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  const SizedBox(height: 10)
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}
