import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie.dart';
import '../common/viewUtils.dart';
import 'package:state_navigation/app/presentation/common/di.dart';

class MoviesListView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MoviesList();

}

class _MoviesList extends State<MoviesListView>{

  @override
  Widget build(BuildContext context) {
    var diProvider = Provider.of<ApplicationDI>(context);
    diProvider.movieListBloc.getMovieList();

    return StreamBuilder(
      stream: diProvider.movieListBloc.moviesListStream,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot){
        if(snapshot.hasData)
          return movieGridLayout(snapshot.data);
        else
          return loadingWidget();
      },
    );
  }

  Widget movieGridLayout(List<Movie> movieList){
    return
      Scaffold(
        appBar: AppBar(title: Text("Movies"),),
        body: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
          children: List.generate(movieList.length, (index) =>  movieList[index]),
        ),
      );
  }
}