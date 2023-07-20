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
}
