import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/model/other_movie_model.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({
    required this.topRatedMovies,
    super.key,
  });
  final OtherMovieModel topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        itemCount: topRatedMovies.results!.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          // Vertical divider between movie items
          return const VerticalDivider(
            color: Colors.transparent,
            thickness: 16.0,
          );
        },
        itemBuilder: (context, index) {
          final data = topRatedMovies.results!;
          return InkWell(
            onTap: () {
              // Navigate to movie detail screen when tapped
              Navigator.pushNamed(
                context,
                '/movie-detail',
                arguments: data[index].id.toString(),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: 150.0,
                height: 250.0,
                child: Column(
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 200.0,
                      child: Stack(
                        children: [
                          // Movie poster image
                          SizedBox(
                            width: 150.0,
                            height: 200.0,
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
                          // Rating badge positioned at top-right corner
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                  Text(
                                    "${data[index].voteAverage}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Expanded(
                      child: Text(
                        data[index].title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
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
