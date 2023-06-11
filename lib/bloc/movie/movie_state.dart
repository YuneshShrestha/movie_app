part of 'movie_bloc.dart';

// MovieState is an abstract class that will be used to represent the state of the MovieBloc.
abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

// MovieInitial is the initial state of the MovieBloc.
class MovieInitial extends MovieState {}

// MovieLoading is the state when the MovieBloc is fetching data from the API.
class MovieLoading extends MovieState {}

// MovieLoaded is the state when the MovieBloc has fetched data from the API.
class MovieLoaded extends MovieState {
  final NowAndUpcomingMovieModel nowPlayingMovies;
  final NowAndUpcomingMovieModel upcomingMovies;
  final OtherMovieModel popularMovies;
  final OtherMovieModel topRatedMovies;
  final GenreModel genre;

  const MovieLoaded({
    required this.nowPlayingMovies,
    required this.upcomingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.genre,
  });
}

// MovieError is the state when the MovieBloc has failed to fetch data from the API.
class MovieError extends MovieState {
  final String? message;

  const MovieError(this.message);
}
