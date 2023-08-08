import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:animate_do/animate_do.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SeachMovieDelegate extends SearchDelegate<Movie?> {
  //* PROPIEDADES DE LA CLASE
  final SearchMoviesCallBack searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SeachMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    isLoadingStream.add(true);
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  StreamBuilder buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 20,
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            child: IconButton(
              onPressed: () => query = '',
              icon: Icon(
                Icons.clear,
                color: color.secondary,
              ),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: color.primary,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  (movie.overview.length > 100)
                      ? Text(
                          movie.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          movie.overview,
                        ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.human(movie.voteAverage, 1),
                        style: textStyle.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.yellow.shade800,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
