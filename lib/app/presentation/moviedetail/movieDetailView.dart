import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';
import 'package:state_navigation/domain/error/error.dart';
import '../../../app/presentation/common/viewUtils.dart';
import '../../../app/presentation/moviedetail/movieDetail.dart';

class MovieDetailView extends StatefulWidget {
  final int id;
  final bool isFavorite;

  const MovieDetailView({Key key, this.id, this.isFavorite}) : super(key: key);

  @override
  _MovieDetailStateView createState() => _MovieDetailStateView(id: id, isFavorite: isFavorite);
}

class _MovieDetailStateView extends State<MovieDetailView> {
  int id;
  bool isFavorite;

  _MovieDetailStateView({this.id, this.isFavorite});

  MovieDetailBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<ApplicationDI>(context).getMovieDetailBloc();
    bloc.getData(params: [id, isFavorite]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: StreamBuilder(
        stream: bloc.movieDetailStream,
        builder: (context, AsyncSnapshot<MovieDetailVM> snapshot) {
          if (snapshot.hasData && snapshot.data == null)
            return Scaffold(
              appBar: AppBar(
                title: Text("Detalhes"),
              ),
              body: loading(),
            );
          if (snapshot.hasData) {
            return _getMovieDetailWidget(snapshot.data);
          }
          if (snapshot.hasError) {
            if (snapshot.error is NetworkException)
              return internetEmptyState(() {
                bloc.loading();
                bloc.getData(params: [id]);
              });
            else
              return Text(snapshot.error.toString());
          } else
            return loading();
        },
      ),
    );
  }

  Widget _getMovieDetailWidget(MovieDetailVM movieDetail) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: movieDetail.url,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                Text(movieDetail.title),
                FlatButton(
                  onPressed: () {
                    bloc.favoriteMovie(movieDetail.isFavorite, movieDetail);
                  },
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  child: Text("Favoritar"),
                ),
                StreamBuilder(
                  stream: bloc.favoriteMovieStream,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data != null) {
                      movieDetail.isFavorite = snapshot.data;
                      return Image.asset(
                        movieDetail.isFavorite
                            ? "images/favorite.png"
                            : "images/unfavorite.png",
                        height: 20,
                        width: 20,
                      );
                    } else {
                      return Image.asset(
                        movieDetail.isFavorite
                            ? "images/favorite.png"
                            : "images/unfavorite.png",
                        height: 20,
                        width: 20,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
