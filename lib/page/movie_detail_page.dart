import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommendation_app/bloc/movie_detail/movie_detail_bloc.dart';

import '../model/genre_model.dart';
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
    _movieBloc = MovieDetailBloc(id: widget.id);
    _movieBloc.add(GetMovieDetailList());
  }

  @override
  void dispose() {
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
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: BlocProvider(
        create: (_) => _movieBloc,
        child: BlocListener<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is MovieDetailError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailInitial) {
                return _buildLoading();
              } else if (state is MovieDetailLoading) {
                return _buildLoading();
              } else if (state is MovieDetailLoaded) {
                return _buildColumnWithData(
                  context,
                  state.movieDetail,
                );
              } else if (state is MovieDetailError) {
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
      BuildContext context, MovieDetailModel movieDetail) {
    const spacer = SizedBox(
      height: 15,
    );
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          backgroundColor: Colors.black,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('${movieDetail.originalTitle}', textScaleFactor: 1),
            background: Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movieDetail.backdropPath}',
                    fit: BoxFit.fill,
                    // color: Colors.black.withOpacity(0.5),
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
                          for (var i = 0; i < movieDetail.genres!.length; i++)
                            Transform(
                              transform: Matrix4.identity()..scale(0.8),
                              child: Chip(
                                backgroundColor: Colors.grey[200],
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                label: Text(movieDetail.genres![i].name!,
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
                              i < movieDetail.productionCompanies!.length;
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
                              i < movieDetail.productionCountries!.length;
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
                            Text(
                              '${movieDetail.spokenLanguages![i].name}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
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
                          backgroundColor: movieDetail.status == 'Released'
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
    );
  }
}
