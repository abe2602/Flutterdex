import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../../../app/presentation/common/viewUtils.dart';
import '../../../app/presentation/moviedetail/models.dart';

class MovieDetailView extends StatefulWidget {
  final int id;
  final bool isFavorite;
  final MovieDetailBloc bloc;

  static Widget create(BuildContext context, int id, bool isFavorite) =>
      MovieDetailView(
        bloc: Provider.of<ApplicationDI>(context).getMovieDetailBloc(context),
        id: id,
        isFavorite: isFavorite,
      );

  const MovieDetailView({Key key, this.id, this.isFavorite, this.bloc})
      : super(key: key);

  @override
  _MovieDetailStateView createState() =>
      _MovieDetailStateView(id: id, isFavorite: isFavorite);
}

class _MovieDetailStateView extends State<MovieDetailView> {
  int id;
  bool isFavorite;

  _MovieDetailStateView({this.id, this.isFavorite});

  @override
  void initState() {
    widget.bloc.getData(params: [id, isFavorite]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: StreamBuilder(
        stream: widget.bloc.movieDetailStream,
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
                widget.bloc.loading();
                widget.bloc.getData(params: [id]);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: movieDetail.url,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Center(
                child: Image.asset(
              "images/no_image.png",
              fit: BoxFit.cover,
            )),
          ),
          Text(movieDetail.title),
          FlatButton(
            onPressed: () {
              widget.bloc.favoriteMovie(movieDetail);
            },
            color: Colors.blueGrey,
            textColor: Colors.white,
            child: Text("Favoritar"),
          ),
          //favoriteImageAsset(movieDetail.isFavorite),
          StreamBuilder(
            stream: widget.bloc.favoriteMovieStream,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) movieDetail.isFavorite = snapshot.data;

              return favoriteImageAsset(movieDetail.isFavorite);
            },
          ),
        ],
      ),
    );
  }
}
