import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';

import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import '../../domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

import '../mappers/actor_mapper.dart';

class ActorsMoviedbDatasource implements ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.apiKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsById(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final movieDbResponse = CastResponse.fromJson(response.data);
    final List<Actor> actors = movieDbResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
    return actors;
  }
}
