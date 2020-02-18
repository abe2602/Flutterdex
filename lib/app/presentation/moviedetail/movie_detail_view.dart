import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/moviedetail/movie_detail_bloc.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../../../app/presentation/common/view_utils.dart';
import '../../../app/presentation/moviedetail/models.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({Key key, this.id, this.isFavorite, this.bloc})
      : super(key: key);

  final int id;
  final bool isFavorite;
  final MovieDetailBloc bloc;

  static Widget create(BuildContext context, int id, bool isFavorite) =>
      MovieDetailView(
        bloc: Provider.of<ApplicationDI>(context).getMovieDetailBloc(context),
        id: id,
        isFavorite: isFavorite,
      );

  @override
  _MovieDetailStateView createState() =>
      _MovieDetailStateView(id: id, isFavorite: isFavorite);
}

class _MovieDetailStateView extends State<MovieDetailView> {
  _MovieDetailStateView({this.id, this.isFavorite});

  int id;
  bool isFavorite;

  @override
  void initState() {
    widget.bloc.getData(params: [id, isFavorite]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        body: StreamBuilder(
          stream: widget.bloc.movieDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == null) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Detalhes'),
                ),
                body: loading(),
              );
            }
            if (snapshot.hasData) {
              return _getMovieDetailWidget(snapshot.data);
            }
            if (snapshot.hasError) {
              if (snapshot.error is NetworkException) {
                return internetEmptyState(() {
                  widget.bloc.loading();
                  widget.bloc.getData(params: [id]);
                });
              } else {
                return Text(snapshot.error.toString());
              }
            } else {
              return loading();
            }
          },
        ),
      );

  Widget _getMovieDetailWidget(MovieDetailVM movieDetail) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: movieDetail.url,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(
                  child: Image.asset(
                'images/no_image.png',
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
              child: const Text('Favoritar'),
            ),
            //favoriteImageAsset(movieDetail.isFavorite),
            StreamBuilder(
              stream: widget.bloc.favoriteMovieStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  movieDetail.isFavorite = snapshot.data;
                }
                return favoriteImageAsset(movieDetail.isFavorite);
              },
            ),
          ],
        ),
      );
}
