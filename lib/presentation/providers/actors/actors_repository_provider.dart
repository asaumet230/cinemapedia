import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasource/actors_moviedb_datasource.dart';
import '../../../infrastructure/repository/actors_repository_imp.dart';

final actorsRepositoryProvider = Provider((ref) {
  // Este provider que ofrece riverpod es de lectura:
  return ActorsRepositoryImp( actorsDatasource: ActorsMoviedbDatasource());
});
