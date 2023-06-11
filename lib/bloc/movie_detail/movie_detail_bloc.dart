import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_recommendation_app/model/movie_detail_model.dart';
import 'package:movie_recommendation_app/resources/api_repository.dart';

part 'movie_detail_events.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final String id;
  MovieDetailBloc({required this.id}) : super(MovieDetailInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetMovieDetailList>((event, emit) async {
      try {
        // Emit MovieDetailLoading() state to show loading indicator
        emit(MovieDetailLoading());
        // Getting data from API
        final movieDetail = await apiRepository.getMovieDetail(id);
        // Emit MovieDetailLoaded() state to show data after getting data from API
        emit(
          MovieDetailLoaded(
            movieDetail: movieDetail,
          ),
        );
      } on NetworkError {
        // Emit MovieDetailError() state to show error message
        emit(const MovieDetailError(
            'Failed to fetch data. Is your device online?'));
      } catch (e) {
        // Emit MovieDetailError() state to show error message
        emit(MovieDetailError(e.toString()));
      }
    });
  }
}
