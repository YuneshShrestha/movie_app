import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie_model.dart';

class UpComingMovies extends StatelessWidget {
  const UpComingMovies({
    required this.upcomingMovies,
    super.key,
  });
  final NowAndUpcomingMovieModel upcomingMovies;

  @override
  Widget build(BuildContext context) {
    // Filtering movies if release date is after today
    final List<Results> filteredMovies = upcomingMovies.results!
        .where((movie) =>
            DateTime.parse(movie.releaseDate!).isAfter(DateTime.now()))
        .toList();

    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemCount: filteredMovies.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          // Vertical divider between movie items
          return const VerticalDivider(
            color: Colors.transparent,
            thickness: 16.0,
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigate to movie detail screen when tapped
              Navigator.pushNamed(
                context,
                '/movie-detail',
                arguments: filteredMovies[index].id.toString(),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SizedBox(
                width: 220.0,
                height: 300.0,
                child: FadeInImage(
                  // Placeholder image while loading
                  placeholder: const AssetImage(
                    'assets/images/place_holder_image.png',
                  ),
                  // Actual movie poster image
                  image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500/${filteredMovies[index].posterPath}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
