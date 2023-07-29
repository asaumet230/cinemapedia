import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

import '../models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/config/constants/environment.dart';

class MoviedbDatasource implements MoviesDatasource {
  //? Se crea el cliente para petición http GET porque este URL es propio de la API the moive db
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.apiKey,
        'language': 'es-MX',
      },
    ),
  );

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final moviedbResponse = MoviedbResponse.fromJson(json);

    final List<Movie> movies = moviedbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.moviedbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovie(response.data);
  }
}
