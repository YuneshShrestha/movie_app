import 'package:dio/dio.dart';
import 'package:movie_recommendation_app/model/genre_model.dart';
import 'package:movie_recommendation_app/model/movie_detail_model.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_recommendation_app/model/other_movie_model.dart';

class ApiProvider {
  // Create Dio instance
  final Dio _dio = Dio();
  // Base url
  final String _url = "https://api.themoviedb.org/3/movie/";
  String getUrl(String path) {
    return "$_url$path";
  }

  // Headers for authorization
  final _headers = {
    "Accept": "application/json",
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZTNjMGRmM2JmNzZiZDkwN2RlYWNjMjA2NzBjYzc2YiIsInN1YiI6IjY0ODQ1MzVjZDJiMjA5MDEyZGZjOTBhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YoxPNuaYf2kL-tl2SquSx-vfzbgNnqhLdZSVdqPkJfI",
  };

  Future<NowAndUpcomingMovieModel> getNowPlayingMovies() async {
    try {
      // Get response from api
      Response response = await _dio.get(
        getUrl('now_playing'),
        options: Options(
          headers: _headers,
        ),
      );
      // Convert response to model
      return NowAndUpcomingMovieModel.fromJson(response.data);
    } catch (e, stacktrace) {
      // If error occured, return empty model
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return NowAndUpcomingMovieModel();
    }
  }

  Future<NowAndUpcomingMovieModel> getUpcomingMovies() async {
    try {
      // Get response from api
      Response response = await _dio.get(
        getUrl('upcoming'),
        options: Options(
          headers: _headers,
        ),
      );
      // Convert response to model
      return NowAndUpcomingMovieModel.fromJson(response.data);
    } catch (e, stacktrace) {
      // If error occured, return empty model
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return NowAndUpcomingMovieModel();
    }
  }

  Future<OtherMovieModel> getPopularMovies() async {
    try {
      // Get response from api
      Response response = await _dio.get(
        getUrl('popular'),
        options: Options(
          headers: _headers,
        ),
      );
      // Convert response to model
      return OtherMovieModel.fromJson(response.data);
    } catch (e, stacktrace) {
      // If error occured, return empty model
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return OtherMovieModel();
    }
  }

  Future<OtherMovieModel> getTopRatedMovies() async {
    try {
      // Get response from api
      Response response = await _dio.get(
        getUrl('top_rated'),
        options: Options(
          headers: _headers,
        ),
      );
      // Convert response to model
      return OtherMovieModel.fromJson(response.data);
    } catch (e, stacktrace) {
      // If error occured, return empty model
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return OtherMovieModel();
    }
  }

  Future<GenreModel> getGenre() async {
    try {
      // Get response from api
      Response response = await _dio.get(
        'https://api.themoviedb.org/3/genre/movie/list',
        options: Options(
          headers: _headers,
        ),
      );
      // Convert response to model
      return GenreModel.fromJson(response.data);
    } catch (e, stacktrace) {
      // If error occured, return empty model
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return GenreModel();
    }
  }

  Future<MovieDetailModel> getMovieDetail({required String id}) async {
    try {
      // Get response from api

      Response response = await _dio.get(
        getUrl(id),
        options: Options(
          headers: _headers,
        ),
      );
      // Convert response to model
      return MovieDetailModel.fromJson(response.data);
    } catch (e, stacktrace) {
      // If error occured, return empty model
      if (kDebugMode) print("Exception occured: $e stackTrace: $stacktrace");
      return MovieDetailModel();
    }
  }
}
