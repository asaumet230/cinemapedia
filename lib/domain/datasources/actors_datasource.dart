import '../entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsById(String movieId);
}
