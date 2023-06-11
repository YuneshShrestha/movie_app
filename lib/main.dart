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
     
      // initialRoute: '/',
      
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "/": (ctx) => const HomePage(),
          "/movie-detail": (ctx) =>
              MovieDetailPage(id: settings.arguments.toString()),
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
      // routes: {
      //   '/': (context) => const HomePage(),
      //   '/movie-detail': (context) => MovieDetailPage(),
      // },
    );
  }
}
