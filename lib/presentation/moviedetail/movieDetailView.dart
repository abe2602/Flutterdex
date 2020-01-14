import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/presentation/moviedetail/movieDetailBloc.dart';

import '../../data/remote/movieDetailRDS.dart';
import '../common/viewUtils.dart';
import 'movieDetail.dart';

class MovieDetailView extends StatefulWidget{
  final int id;
  const MovieDetailView({Key key, this.id}) : super(key: key);
  @override
  _MovieDetailStateView createState() => _MovieDetailStateView(id: id);

}

class _MovieDetailStateView extends State<MovieDetailView>{
  int id;
  MovieDetailBloc movieDetailBloc;

  _MovieDetailStateView({this.id});

  @override
  void initState() {
    movieDetailBloc = MovieDetailBloc();
    movieDetailBloc.getMovieDetail(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailRDS().getMovieDetail(id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: StreamBuilder(
        stream: movieDetailBloc.movieDetailStream,
        builder: (context, AsyncSnapshot<MovieDetail> snapshot){
          if(snapshot.hasData){
            return snapshot.data;
          }
          else{
            return loadingWidget();
          }
        },
      )
    );
  }
}