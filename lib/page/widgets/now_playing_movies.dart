import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/model/now_and_upcoming_movie_model.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    required this.nowPlayingMovies,
    super.key,
  });
  final NowAndUpcomingMovieModel nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
          itemCount: nowPlayingMovies.results!.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return const VerticalDivider(
              color: Colors.transparent,
              thickness: 16.0,
            );
          },
          itemBuilder: (context, index) {
            final data = nowPlayingMovies.results!;
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: 150.0,
                height: 250.0,
                child: Column(
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 200.0,
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500/${data[index].posterPath}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Expanded(
                        child: Text(data[index].title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ))),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
