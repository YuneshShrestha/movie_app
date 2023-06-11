import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/bloc/movie/movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommendation_app/model/genre_model.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie_model.dart';
import 'package:movie_recommendation_app/model/other_movie_model.dart';
import 'package:movie_recommendation_app/page/widgets/now_playing_movies.dart';
import 'package:movie_recommendation_app/page/widgets/popular_movies.dart';
import 'package:movie_recommendation_app/page/widgets/top_rated_movies.dart';
import 'package:movie_recommendation_app/page/widgets/upcoming_movies.dart';
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
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        centerTitle: true,
      ),
      body: _buildMovieList(),
    );
  }

  Widget _buildMovieList() {
    return BlocProvider(
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
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                child: _buildColumnWithData(
                  context,
                  state.nowPlayingMovies,
                  state.upcomingMovies,
                  state.popularMovies,
                  state.topRatedMovies,
                  state.genre,
                ),
              );
            } else if (state is MovieError) {
              return const Center(
                child: Text("Error"),
              );
            }
            return Container();
          },
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
      NowAndUpcomingMovieModel upcomingMovies,
      OtherMovieModel popularMovies,
      OtherMovieModel topRatedMovies,
      GenreModel genre) {
    const spacer = SizedBox(
      height: 15,
    );
    return (nowPlayingMovies.results == null ||
            upcomingMovies.results == null ||
            popularMovies.results == null ||
            topRatedMovies.results == null ||
            genre.genres == null)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Something went wrong. Might be problem with api or your internet connection.",
                ),
                ElevatedButton(
                  onPressed: () {
                    _movieBloc.add(GetMovieList());
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              _movieBloc.add(GetMovieList());
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacer,
                  const TextWidget(text: 'Upcoming Movies'),
                  spacer,
                  UpComingMovies(
                    upcomingMovies: upcomingMovies,
                  ),
                  spacer,
                  const TextWidget(text: 'Now Playing Movies'),
                  spacer,
                  NowPlaying(
                    nowPlayingMovies: nowPlayingMovies,
                  ),
                  spacer,
                  const TextWidget(text: 'Top Rated Movies'),
                  spacer,
                  TopRatedMovies(
                    topRatedMovies: topRatedMovies,
                  ),
                  spacer,
                  const TextWidget(text: 'Popular Movies'),
                  spacer,
                  PopularMovies(
                    popularMovies: popularMovies,
                    genre: genre,
                  ),
                ],
              ),
            ),
          );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    );
  }
}
