import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/presentation/common/di.dart';
import '../../../app/presentation/common/viewUtils.dart';
import '../../../app/presentation/moviedetail/movieDetail.dart';

class MovieDetailView extends StatefulWidget{
  final int id;
  const MovieDetailView({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailStateView createState() => _MovieDetailStateView(id: id);

}

class _MovieDetailStateView extends State<MovieDetailView>{
  int id;
  _MovieDetailStateView({this.id});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApplicationDI>(context);
    provider.movieDetailBloc.getMovieDetail(id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: StreamBuilder(
        stream: provider.movieDetailBloc.movieDetailStream,
        builder: (context, AsyncSnapshot<MovieDetailVM> snapshot){
          if(snapshot.hasData){
            return snapshot.data;
          }
          else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else{
            return loadingWidget();
          }
        },
      ),
    );
  }
}