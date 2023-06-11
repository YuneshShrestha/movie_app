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
    return SizedBox(
      height: 300,
      child: ListView.separated(
          itemCount: upcomingMovies.results!.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return const VerticalDivider(
              color: Colors.transparent,
              thickness: 16.0,
            );
          },
          itemBuilder: (context, index) {
            final data = upcomingMovies.results!;
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    '/movie-detail', arguments: data[index].id.toString(),);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SizedBox(
                  width: 220.0,
                  height: 300.0,
                  child: Stack(
                    children: [
                      // Background Image
                      Image.network(
                        "https://image.tmdb.org/t/p/w500/${data[index].posterPath}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),

                      Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0))),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                  Text("${data[index].voteAverage}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16.0)),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
