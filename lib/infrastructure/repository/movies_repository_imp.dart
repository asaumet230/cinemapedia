import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import '../../domain/datasources/movies_datasource.dart';

class MoviesRespositoryImp implements MoviesRepository {
  final MoviesDatasource dataSource;

  MoviesRespositoryImp(this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return dataSource.getTopRated();
  }

  @override
  Future<List<Movie>> getUpCooming({int page = 1}) {
    return dataSource.getUpcoming();
  }

  @override
  Future<Movie> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    return dataSource.searchMovie(query);
  }
}
