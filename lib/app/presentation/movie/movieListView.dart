import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/app/presentation/movie/movieListUI.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../common/viewUtils.dart';
import 'movie.dart';

//todo: problemas com a injeção
class MoviesListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesList();
}

class _MoviesList extends State<MoviesListView> implements MovieListUI {
  @override
  MovieListBloc movieListBloc = MovieListBloc();

  @override
  void initState() {
    super.initState();
    movieListBloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: StreamBuilder(
        stream: movieListBloc.moviesListStream,
        builder: (context, AsyncSnapshot<List<MovieVM>> snapshot) {
          if (snapshot.hasData && snapshot.data.isEmpty)
            return loading();
          if (snapshot.hasData)
            return movieGridLayout(snapshot.data);
          if (snapshot.hasError) {
            if (snapshot.error is NetworkException)
              return internetEmptyState(() {
                movieListBloc.loading();
                movieListBloc.getData();
              });
            else
              return Text(snapshot.error.toString());
          } else
            return loading();
        },
      ),
    );
  }

  Widget movieGridLayout(List<MovieVM> movieList) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
      children: List.generate(movieList.length, (index) => movieList[index]),
    );
  }
}
