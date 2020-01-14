import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/presentation/movie/movieListBloc.dart';
import 'movie.dart';

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
      stream: movieListBloc.moviesListStream,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot){
        if(snapshot.hasData)
          return movieGridLayout(snapshot.data);
        else
          return movieGridLayout([]);
      },
    );
  }

  Widget movieGridLayout(List<Movie> movieList){
    return
      Scaffold(
        appBar: AppBar(title: Text("Hey"),),
        body: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
          children: List.generate(movieList.length, (index) =>  movieList[index]),
        ),
      );
  }
}