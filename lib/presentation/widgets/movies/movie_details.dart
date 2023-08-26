import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';
import '../widgets.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTitleOverview(movie: movie),
        MovieGenres(genreIds: movie.genreIds),
        ActorsMovie(movieId: movie.id.toString()),
        VideosFromMovie(movieId: movie.id),
        SimilarMovies(movieId: movie.id),
        const SizedBox(height: 50)
      ],
    );
  }
}
