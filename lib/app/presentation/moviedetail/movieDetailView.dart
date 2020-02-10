import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';
import 'package:state_navigation/domain/error/error.dart';
import '../../../app/presentation/common/viewUtils.dart';
import '../../../app/presentation/moviedetail/movieDetail.dart';

class MovieDetailView extends StatefulWidget {
  final int id;

  const MovieDetailView({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailStateView createState() => _MovieDetailStateView(id: id);
}

class _MovieDetailStateView extends State<MovieDetailView> {
  int id;
  MovieDetailBloc movieDetailBloc;

  _MovieDetailStateView({this.id});

  @override
  void initState() {
    movieDetailBloc = MovieDetailBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    movieDetailBloc.getData(id: id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: StreamBuilder(
        stream: movieDetailBloc.movieDetailStream,
        builder: (context, AsyncSnapshot<MovieDetailVM> snapshot) {
          if (snapshot.hasData && snapshot.data == null)
            return Scaffold(
              appBar: AppBar(
                title: Text("Detalhes"),
              ),
              body: loading(),
            );
          if (snapshot.hasData) return snapshot.data;
          if (snapshot.hasError) {
            if (snapshot.error is NetworkException)
              return internetEmptyState(() {
                movieDetailBloc.loading();
                movieDetailBloc.getData(id: id);
              });
            else
              return Text(snapshot.error.toString());
          } else
            return loading();
        },
      ),
    );
  }
}
