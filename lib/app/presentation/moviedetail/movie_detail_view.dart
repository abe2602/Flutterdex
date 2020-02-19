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

  Widget internetImage(String url, double width, double height) =>
      CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset(
          'images/no_image.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        fit: BoxFit.cover,
      );

  Widget _getFavoriteButton(MovieDetailVM movieDetail) => FlatButton(
        onPressed: () {
          widget.bloc.favoriteMovie(movieDetail);
        },
        color: Colors.blueGrey,
        textColor: Colors.white,
        child: const Text('Favoritar'),
      );

  Widget _getMovieDetailWidget(MovieDetailVM movieDetail) => Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Material(
                elevation: 3,
                child: internetImage(
                    movieDetail.url,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 7),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 10),
                child: StreamBuilder(
                  stream: widget.bloc.favoriteMovieStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail.isFavorite = snapshot.data;
                    }
                    return favoriteImageAsset(movieDetail.isFavorite);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 10,
                  left: MediaQuery.of(context).size.width / 10,
                ),
                child: Row(
                  children: <Widget>[
                    internetImage(
                        movieDetail.url,
                        MediaQuery.of(context).size.width / 4,
                        MediaQuery.of(context).size.height / 6),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          movieDetail.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _getFavoriteButton(movieDetail),
        ],
      );
}
