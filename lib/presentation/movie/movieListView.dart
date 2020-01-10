import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/presentation/movie/movieListBloc.dart';
import 'movie.dart';
import '../../data/movieRDS.dart';
import '../../data/movieRM.dart';
import '../../data/mapper.dart';

class MoviesListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MoviesList();
  }

}

class _MoviesList extends State<MoviesListView>{
  MovieListBloc movieListBloc;
//  List<Movie> moviesVM = [];

//  void _getMovies() async {
//    final Stream<MovieRM> movies = await getMovies();
//    movies.listen( (MovieRM movie){
//      setState(() {
//        moviesVM.add(movie.toVM());
//      });
//    });
//  }

  @override
  void initState() {
    super.initState();
    //_getMovies();
    movieListBloc = MovieListBloc();
    movieListBloc.getMovieList();
  }
  //Colocar o stream builder aqui
  @override
  Widget build(BuildContext context) {
    return
      GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
      children: List.generate(movieListBloc.moviesVM.length, (index) =>  movieListBloc.moviesVM[index]),
    );
  }
}