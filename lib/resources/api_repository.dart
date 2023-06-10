import 'package:movie_recommendation_app/model/now_and_upcoming_movie.dart';
import 'api_provider.dart';

class ApiRepository {
  final apiProvider = ApiProvider();

  Future<NowAndUpcomingMovieModel> getNowPlayingMovies() =>
      apiProvider.getNowPlayingMovies();
  Future<NowAndUpcomingMovieModel> getUpcomingMovies() =>
      apiProvider.getUpcomingMovies();
}

class NetworkError extends Error {}
