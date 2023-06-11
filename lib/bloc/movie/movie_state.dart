part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

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

class MovieError extends MovieState {
  final String? message;

  const MovieError(this.message);
}
