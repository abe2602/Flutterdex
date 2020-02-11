import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/common/viewUtils.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';

class MovieDetailVM extends StatefulWidget {
  final int id;
  final double voteAverage;
  final String title;
  final String url;
  final String date;
  final bool isFavorite;

  MovieDetailVM(this.id, this.voteAverage, this.title, this.url, this.date,
      this.isFavorite);

  @override
  State<StatefulWidget> createState() => _MovieDetailVM(
      id: id,
      voteAverage: voteAverage,
      title: title,
      url: url,
      date: date,
      isFavorite: isFavorite);
}

class _MovieDetailVM extends State<MovieDetailVM> {
  int id;
  double voteAverage;
  String title;
  String url;
  String date;
  bool isFavorite;

  _MovieDetailVM(
      {Key key,
      @required this.id,
      @required this.voteAverage,
      @required this.title,
      @required this.url,
      @required this.date,
      @required this.isFavorite})
      : assert(id != null),
        assert(voteAverage != null),
        assert(title != null),
        assert(date != null),
        assert(url != null),
        assert(isFavorite != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                Text(title),
                FlatButton(
                  onPressed: () {
                    locator<MovieDetailBloc>().favoriteMovie();
                  },
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  child: Text("Favoritar"),
                ),
                StreamBuilder(
                    stream: locator<MovieDetailBloc>().favoriteMovieStream,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data != null)
                        return Image.asset(
                          snapshot.data
                              ? "images/favorite.png"
                              : "images/unfavorite.png",
                          height: 30,
                          width: 30,
                        );
                      else
                        return loading();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
