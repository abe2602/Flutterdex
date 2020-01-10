import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'movie.dart';
import 'data/movieRDS.dart';
import 'data/movieRM.dart';
import 'data/mapper.dart';

class MoviesList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MoviesList();
  }

}

class _MoviesList extends State<MoviesList>{
  List<Movie> moviesVM = [];

  void _getMovies() async {
    final Stream<MovieRM> movies = await getMovies();
    movies.listen( (MovieRM movie){
      setState(() {
        moviesVM.add(movie.toVM());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
      children: List.generate(moviesVM.length, (index) =>  moviesVM[index]),
    );
  }
}