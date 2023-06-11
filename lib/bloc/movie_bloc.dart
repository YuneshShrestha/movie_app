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
      emit(MovieLoading());
      try {
        emit(MovieLoading());
        final nowPlayingMovies = await apiRepository.getNowPlayingMovies();
        final upcomingMovies = await apiRepository.getUpcomingMovies();

        final topRatedMovies = await apiRepository.getTopRatedMovies();
        final popularMovies = await apiRepository.getPopularMovies();
        final genre = await apiRepository.getGenre();

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
        emit(const MovieError('Failed to fetch data. Is your device online?'));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
