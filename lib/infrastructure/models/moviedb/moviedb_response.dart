import 'moviedb_date.dart';
import 'moviedb_movie.dart';

class MoviedbResponse {
  final Dates? dates;
  final int page;
  final List<MoviedbMovie> results;
  final int totalPages;
  final int totalResults;

  MoviedbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviedbResponse.fromJson(Map<String, dynamic> json) =>
      MoviedbResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MoviedbMovie>.from(
          json["results"].map(
            (x) => MoviedbMovie.fromJson(x),
          ),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "results": List<dynamic>.from(
          results.map(
            (x) => x.toJson(),
          ),
        ),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
