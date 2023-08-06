import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImp implements ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorsRepositoryImp({required this.actorsDatasource});

  @override
  Future<List<Actor>> getActorsById(String movieId) {
    return actorsDatasource.getActorsById(movieId);
  }
}
