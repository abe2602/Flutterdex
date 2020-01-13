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
  MovieListBloc movieListBloc = MovieListBloc();

  @override
  void initState() {
    super.initState();
    movieListBloc.getMovieList();
  }

  //Colocar o stream builder aqui
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieListBloc.allMovies,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot){
        if(snapshot.hasData)
          return
            GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
            children: List.generate(snapshot.data.length, (index) =>  snapshot.data[index]),
          );
        else
          return Text("Hey");
      },
    );
  }
}