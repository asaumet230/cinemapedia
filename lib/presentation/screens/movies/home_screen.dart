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
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

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
                    title: 'In Cinema',
                    subTitle: 'Monday 20',
                    loadNextPage: () => ref
                        .watch(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Cooming Soon',
                    subTitle: 'In 2023',
                    loadNextPage: () => ref
                        .watch(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: popularMovies,
                    title: 'Popular',
                    subTitle: 'Pop Movies',
                    loadNextPage: () => ref
                        .watch(popularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Top Rated',
                    subTitle: 'By Academics',
                    loadNextPage: () => ref
                        .watch(nowPlayingMoviesProvider.notifier)
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
