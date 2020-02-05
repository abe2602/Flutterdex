import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../common/viewUtils.dart';
import 'movie.dart';

//todo: problemas com a injeção
class MoviesListView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MoviesList();

}

class _MoviesList extends State<MoviesListView>{
  MovieListBloc movieListBloc;

  @override
  void initState() {
    super.initState();
    movieListBloc  = MovieListBloc();
    movieListBloc.getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: Text("Movies"),),
        body:
        StreamBuilder(
          stream: movieListBloc.moviesListStream,
          builder: (context, AsyncSnapshot<List<MovieVM>> snapshot){
            if(snapshot.hasData  && snapshot.data.isEmpty)
              return loadingWidget();
            if(snapshot.hasData)
              return movieGridLayout(snapshot.data);
            if(snapshot.hasError){
              if(snapshot.error is NetworkError)
                return internetEmptyState((){
                  movieListBloc.callLoading();
                  movieListBloc.getMovieList();
                });
              else return Text(snapshot.error.toString());
            }
            else return loadingWidget();
          },
        ),
      );
  }

  Widget movieGridLayout(List<MovieVM> movieList){
    return
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
        children: List.generate(movieList.length, (index) =>  movieList[index]),
      );
  }
}