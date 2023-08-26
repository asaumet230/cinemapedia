import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_rating.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';

class MovieTitleOverview extends StatelessWidget {
  final Movie movie;

  const MovieTitleOverview({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStyle.titleLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(movie.overview),
                const SizedBox(height: 10),
                MovieRating(voteAverage: movie.voteAverage),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'Estreno:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Text(HumanFormats.shortDate(movie.releaseDate))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
