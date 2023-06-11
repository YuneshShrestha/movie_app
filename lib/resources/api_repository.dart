import 'package:movie_recommendation_app/model/genre_model.dart';
import 'package:movie_recommendation_app/model/movie_detail_model.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie_model.dart';
import 'package:movie_recommendation_app/model/other_movie_model.dart';
import 'api_provider.dart';
// ApiProvider is a class that will be used to get data from API.
// This class will be used by ApiRepository class to get data from API.
class ApiRepository {
  final apiProvider = ApiProvider();

  Future<NowAndUpcomingMovieModel> getNowPlayingMovies() =>
      apiProvider.getNowPlayingMovies();
  Future<NowAndUpcomingMovieModel> getUpcomingMovies() =>
      apiProvider.getUpcomingMovies();
  Future<OtherMovieModel> getPopularMovies() => apiProvider.getPopularMovies();
  Future<OtherMovieModel> getTopRatedMovies() =>
      apiProvider.getTopRatedMovies();
  Future<GenreModel> getGenre() => apiProvider.getGenre();
  Future<MovieDetailModel> getMovieDetail(String id) => apiProvider.getMovieDetail(id: id);
  
}

class NetworkError extends Error {}
