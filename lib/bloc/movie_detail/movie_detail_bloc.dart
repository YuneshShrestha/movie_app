import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_recommendation_app/model/movie_detail_model.dart';
import 'package:movie_recommendation_app/resources/api_repository.dart';

part 'movie_detail_events.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final String id;
  MovieDetailBloc({required this.id}) : super(const MovieDetailState()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetMovieDetailList>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        emit(MovieDetailLoading());
        final movieDetail = await apiRepository.getMovieDetail(id);


        emit(
          MovieDetailLoaded(
            movieDetail: movieDetail,
            
          ),
        );
      } on NetworkError {
        emit(const MovieDetailError(
            'Failed to fetch data. Is your device online?'));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });
  }
}
