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
            return const VerticalDivider(
              color: Colors.transparent,
              thickness: 16.0,
            );
          },
          itemBuilder: (context, index) {
            final data = topRatedMovies.results!;
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
                    Expanded(
                        child: Text(data[index].title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
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
