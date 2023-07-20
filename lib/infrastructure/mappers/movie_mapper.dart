import '../../domain/entities/movie.dart';
import '../models/moviedb/moviedb_movie.dart';

class MovieMapper {
  static Movie moviedbToEntity(MoviedbMovie moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://i.pinimg.com/736x/06/be/b8/06beb8cc89f6e0e6e5cc8346ab221a77--stress-less-stress-free.jpg',
        genreIds: moviedb.genreIds.map((id) => id.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'no-poster',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );
}
