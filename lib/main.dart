import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/page/home_page.dart';
import 'package:movie_recommendation_app/page/movie_detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // routes: {
      //   '/': (context) => const HomePage(),
      //   '/movie-detail': (context) =>  MovieDetailPage(),
      // },
    );
  }
}
