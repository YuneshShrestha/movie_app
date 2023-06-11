part of 'movie_detail_bloc.dart';

// MovieDetailState is an abstract class that will be used to represent the state of the MovieDetailBloc.
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

// MovieDetailInitial is the initial state of the MovieDetailBloc.
class MovieDetailInitial extends MovieDetailState {}

// MovieDetailLoading is the state when the MovieDetailBloc is fetching data from the API.
class MovieDetailLoading extends MovieDetailState {}

// MovieDetailLoaded is the state when the MovieDetailBloc has fetched data from the API.
class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movieDetail;

  const MovieDetailLoaded({
    required this.movieDetail,
  });
}

// MovieDetailError is the state when the MovieDetailBloc has failed to fetch data from the API.
class MovieDetailError extends MovieDetailState {
  final String? message;

  const MovieDetailError(this.message);
}
