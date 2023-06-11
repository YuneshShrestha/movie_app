import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_recommendation_app/model/genre_model.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie_model.dart';
import 'package:movie_recommendation_app/model/other_movie_model.dart';
import 'package:movie_recommendation_app/resources/api_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetMovieList>((event, emit) async {
      try {
        // Emit MovieLoading() state to show loading indicator
        emit(MovieLoading());
        // Getting data from API
        final nowPlayingMovies = await apiRepository.getNowPlayingMovies();
        final upcomingMovies = await apiRepository.getUpcomingMovies();

        final topRatedMovies = await apiRepository.getTopRatedMovies();
        final popularMovies = await apiRepository.getPopularMovies();
        final genre = await apiRepository.getGenre();

        // Emit MovieLoaded() state to show data after getting data from API
        emit(
          MovieLoaded(
            nowPlayingMovies: nowPlayingMovies,
            upcomingMovies: upcomingMovies,
            popularMovies: popularMovies,
            topRatedMovies: topRatedMovies,
            genre: genre,
          ),
        );
      } on NetworkError {
        // Emit MovieError() state to show error message
        emit(const MovieError('Failed to fetch data. Is your device online?'));
      } catch (e) {
        // Emit MovieError() state to show error message
        emit(MovieError(e.toString()));
      }
    });
  }
}
