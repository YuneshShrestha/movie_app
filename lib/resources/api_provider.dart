import 'package:dio/dio.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String url = "https://api.themoviedb.org/3/movie/";
  String getUrl(String path) {
    return "$url$path";
  }

  Future<NowAndUpcomingMovieModel> getNowPlayingMovies() async {
    try {
      Response response = await _dio.get(
        getUrl('now_playing'),
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZTNjMGRmM2JmNzZiZDkwN2RlYWNjMjA2NzBjYzc2YiIsInN1YiI6IjY0ODQ1MzVjZDJiMjA5MDEyZGZjOTBhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YoxPNuaYf2kL-tl2SquSx-vfzbgNnqhLdZSVdqPkJfI",
          },
        ),
      );
      return NowAndUpcomingMovieModel.fromJson(response.data);
    } catch (e, stacktrace) {
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return NowAndUpcomingMovieModel();
    }
  }

  Future<NowAndUpcomingMovieModel> getUpcomingMovies() async {
    try {
      Response response = await _dio.get(
        getUrl('upcoming'),
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZTNjMGRmM2JmNzZiZDkwN2RlYWNjMjA2NzBjYzc2YiIsInN1YiI6IjY0ODQ1MzVjZDJiMjA5MDEyZGZjOTBhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YoxPNuaYf2kL-tl2SquSx-vfzbgNnqhLdZSVdqPkJfI",
          },
        ),
      );
      return NowAndUpcomingMovieModel.fromJson(response.data);
    } catch (e, stacktrace) {
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return NowAndUpcomingMovieModel();
    }
  }
}
