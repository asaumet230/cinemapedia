import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import '../../../domain/entities/movie.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  final String title;
  final String subtitle;

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
    required this.title,
    required this.subtitle,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Row(
            children: [
              Text(
                widget.title,
                style: textStyle.titleLarge,
              ),
              const Spacer(),
              FilledButton.tonal(
                onPressed: () {},
                child: Text(
                  widget.subtitle,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: MasonryGridView.count(
              controller: scrollController,
              crossAxisCount: 3,
              itemCount: widget.movies.length,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];

                if (index == 1) {
                  return Column(
                    children: [
                      const SizedBox(height: 40),
                      MoviePosterLink(movie: movie)
                    ],
                  );
                }

                return MoviePosterLink(movie: movie);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
