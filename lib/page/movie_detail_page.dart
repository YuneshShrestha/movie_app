import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommendation_app/bloc/movie_detail/movie_detail_bloc.dart';

import '../model/movie_detail_model.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailBloc _movieBloc;

  @override
  void initState() {
    super.initState();
  // Fetch movie data when this page is loaded using the id 
    _movieBloc = MovieDetailBloc(id: widget.id);
    _movieBloc.add(GetMovieDetailList());
  }

  @override
  void dispose() {
    // Close the bloc when this page is disposed
    _movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildMovieDetailList(),
      ),
    );
  }

  Widget _buildMovieDetailList() {
    // BlocProvider is used to provide the bloc to its children
    return BlocProvider(
      create: (_) => _movieBloc,
      // BlocListener is used to listen to the state changes in the bloc
      child: BlocListener<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          // Show snackbar when the state is MovieError
          if (state is MovieDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        // BlocBuilder is used to rebuild the UI based on the state in the bloc
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailInitial) {
            // Show loading indicator when the app is first loaded

              return _buildLoading();
            } else if (state is MovieDetailLoading) {
              // Show loading indicator when the data is being fetched
              return _buildLoading();
            } else if (state is MovieDetailLoaded) {
              // Show the movie list when the data is loaded
              return _buildColumnWithData(
                context,
                state.movieDetail,
              );
            } else if (state is MovieDetailError) {
              // Show error message when the data is not loaded
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
      BuildContext context, MovieDetailModel movieDetail) {
    const spacer = SizedBox(
      height: 15,
    );
    // Check if the data is null or not
    // If the data is null, show error message
    // If the data is not null, show the data
    return (movieDetail.backdropPath == null ||
            movieDetail.originalTitle == null ||
            movieDetail.overview == null ||
            movieDetail.posterPath == null ||
            movieDetail.releaseDate == null ||
            movieDetail.voteAverage == null ||
            movieDetail.voteCount == null)
        ? Center(
            child: Column(
              children: [
                const Text(
                  "Something went wrong. Might be problem with api or your internet connection.",
                ),
                ElevatedButton(
                  onPressed: () {
                    _movieBloc.add(GetMovieDetailList());
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              _movieBloc.add(GetMovieDetailList());
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  backgroundColor: Colors.black,
                  pinned: true,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('${movieDetail.originalTitle}',
                        textScaleFactor: 1),
                    background: Stack(
                      children: [
                        SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage(
                                'assets/images/place_holder_image.png'),
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}',
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spacer,

                              Text(
                                'Release Date: ${movieDetail.releaseDate}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Text(
                                '${movieDetail.overview}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              spacer,
                              const Text(
                                'Genre',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Wrap(
                                runSpacing: 4,
                                spacing: 0.4,
                                children: [
                                  for (var i = 0;
                                      i < movieDetail.genres!.length;
                                      i++)
                                    Transform(
                                      transform: Matrix4.identity()..scale(0.8),
                                      child: Chip(
                                        backgroundColor: Colors.grey[200],
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        label:
                                            Text(movieDetail.genres![i].name!,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0,
                                                )),
                                      ),
                                    ),
                                ],
                              ),

                              spacer,

                              const Text(
                                'Production Company',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i <
                                          movieDetail
                                              .productionCompanies!.length;
                                      i++)
                                    Row(
                                      children: [
                                        const Text(
                                          '\u2022',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${movieDetail.productionCompanies![i].name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),

                              spacer,
                              // spacer,
                              // _buildProductionCompany(movieDetail),
                              spacer,
                              const Text(
                                'Production Country',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i <
                                          movieDetail
                                              .productionCountries!.length;
                                      i++)
                                    Row(
                                      children: [
                                        const Text(
                                          '\u2022',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${movieDetail.productionCountries![i].name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                              spacer,
                              const Text(
                                'Spoken Language',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i < movieDetail.spokenLanguages!.length;
                                      i++)
                                    Row(
                                      children: [
                                        const Text(
                                          '\u2022',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${movieDetail.spokenLanguages![i].name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              spacer,
                              const Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Chip(
                                  backgroundColor:
                                      movieDetail.status == 'Released'
                                          ? Colors.green
                                          : Colors.red,
                                  label: Text(
                                    '${movieDetail.status}',
                                  )),

                              spacer,
                              const Text(
                                'Vote Average',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              spacer,
                              Text(
                                '${movieDetail.voteAverage}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              spacer,
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
