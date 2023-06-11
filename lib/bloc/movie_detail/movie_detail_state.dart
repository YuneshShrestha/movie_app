part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, loading, success, failure }

class MovieDetailState extends Equatable {
  const MovieDetailState();


  @override
  List<Object?> get props => [];

  
}
class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
 final MovieDetailModel movieDetail;

  const MovieDetailLoaded({
    required this.movieDetail,

  });
  
}

class MovieDetailError extends MovieDetailState {
  final String? message;

  const MovieDetailError(this.message);
}
