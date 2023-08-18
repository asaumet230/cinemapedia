import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/repository/local_storage_repository_imp.dart';
import 'package:cinemapedia/infrastructure/datasource/isar_datasource.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImp(localStorageDatasource: IsarDatasource());
});
