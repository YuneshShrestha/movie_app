import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/bloc/movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie.dart';
// import 'package:movie_recommendation_app/model/upcoming_movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieBloc _movieBloc = MovieBloc();
  @override
  void initState() {
    super.initState();
    _movieBloc.add(GetMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Recommendation"),
      ),
      body: _buildMovieList(),
    );
  }

  Widget _buildMovieList() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: BlocProvider(
        create: (_) => _movieBloc,
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieInitial) {
                return _buildLoading();
              } else if (state is MovieLoading) {
                return _buildLoading();
              } else if (state is MovieLoaded) {
                return _buildColumnWithData(
                    context, state.nowPlayingMovies, state.upcomingMovies);
              } else if (state is MovieError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildColumnWithData(
      BuildContext context,
      NowAndUpcomingMovieModel nowPlayingMovies,
      NowAndUpcomingMovieModel upcomingMovies) {
    return Column(
      children: nowPlayingMovies.results == null
          ? []
          : nowPlayingMovies.results!.map((e) => Text(e.title ?? "")).toList(),
    );
  }
}
