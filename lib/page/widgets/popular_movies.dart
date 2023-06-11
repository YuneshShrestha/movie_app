import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/model/genre_model.dart';
import 'package:movie_recommendation_app/model/other_movie_model.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({
    required this.popularMovies,
    required this.genre,
    super.key,
  });
  final OtherMovieModel popularMovies;
  final GenreModel genre;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256 * popularMovies.results!.length.toDouble(),
      child: ListView.separated(
        itemCount: popularMovies.results!.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          // Divider between movie items
          return const Divider(
            color: Colors.transparent,
            height: 16.0,
          );
        },
        itemBuilder: (context, index) {
          final data = popularMovies.results!;
          return InkWell(
            onTap: () {
              // Navigate to movie detail screen when tapped
              Navigator.pushNamed(
                context,
                '/movie-detail',
                arguments: data[index].id.toString(),
              );
            },
            child: SizedBox(
              height: 240.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 240.0,
                      child: ClipRRect(
                        // Movie poster image
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        child: FadeInImage(
                          // Placeholder image while loading
                          placeholder: const AssetImage(
                            'assets/images/place_holder_image.png',
                          ),
                          // Actual movie poster image
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500/${data[index].posterPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Movie title
                              Text(
                                data[index].title.toString(),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  // Star icon for rating
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 14.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  // Movie rating
                                  Text(
                                    "${data[index].voteAverage}/10",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              // Release date
                              Text(
                                "Release Date: ${data[index].releaseDate}",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Wrap(
                                spacing: 0.4,
                                children: [
                                  // Genre chips
                                  for (var i = 0;
                                      i < data[index].genreIds!.length;
                                      i++)
                                    Transform(
                                      transform: Matrix4.identity()..scale(0.8),
                                      child: Chip(
                                        backgroundColor: Colors.grey[200],
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        label: Text(
                                          "${genre.genres!.where((element) => element.id == data[index].genreIds![i]).first.name}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
