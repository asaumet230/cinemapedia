import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repository/movies_repository_imp.dart';
import 'package:cinemapedia/infrastructure/datasource/moviedb_datasource.dart';

final moviesRepositoryProvider = Provider((ref) {
  // Este provider que ofrece riverpod es de lectura:
  return MoviesRespositoryImp(MoviedbDatasource());
});
